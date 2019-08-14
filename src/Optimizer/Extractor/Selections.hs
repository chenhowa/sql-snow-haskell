module Optimizer.Extractor.Selections where

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L
import qualified Data.Char as Char
import Optimizer.Extractor.Projections (tableAndColumn)
import qualified Optimizer.Extractor.Tables as T
import Control.Applicative as A

{- As far as I can tell, the granularity of selections can be at any level ranging from one table, to all tables in the query.
Consequently, it initially doesn't make sense to pair selections directly with table info. It *does* make sense to project 
immediately, since an analysis can be done from the very beginning to learn what columns are needed from a given table for the 
rest of the query. Certainly you should push selections down when possible, but that can be done during construction of the
query plan, rather than immediately.


-}

type SelectionStream = [ SelectionInfo ]
data SelectionInfo = SelectionInfo
    { tables :: [Table]
    , expr :: P.Expr

    }
    deriving (Show)

instance Eq SelectionInfo where 
    (==) a b = 
        let exprEquality = (expr a == expr b)
            memberEquality = 
                let map1 = Map.fromList $ fmap (flip (,) False) (tables a)
                    map2 = Map.fromList $ fmap (flip (,) False) (tables b)
                in map1 == map2
        in exprEquality && memberEquality

type Table = (Name, Maybe Alias)
type Name = String
type Alias = String
type Error = String

type TablesUsed = Map.Map Name Bool
type Abort = Bool

-- extract goes down into a where statement and generates a list of all selections that need to be done
-- on the tables, where we try to push all selections as far down as possible
extract :: T.ValidTableInfo -> P.Where -> Either Error SelectionStream
extract (tmap, amap) wh = 
    let m = extract_ (Right $ (Map.empty, False, [])) wh
    in  case m of 
            Left str -> Left str
            Right (_, _, stream) -> Right stream

    where 
        extract_ :: Either Error (TablesUsed, Abort, SelectionStream) -> P.Expr -> Either Error (TablesUsed, Abort, SelectionStream)
        extract_ either@(Left _) _ = either
        extract_ either@(Right (map, abort, stream)) ex = do 
            case ex of 
                P.Constant _ -> -- a constant doesn't change the tables, doesn't provoke abort, and it doesn't provide any selections
                    Right $ (map, False, [])
                P.Identifier str -> 
                    case tableAndColumn str of 
                        Nothing -> 
                            if Map.size tmap == 1
                            then case L.uncons $ Map.toList tmap of 
                                Nothing -> Left $ "Unexpectedly, no tables"
                                Just ((name, multtimes), _) -> 
                                    if multtimes 
                                    then Left $ "In WHERE clause, column \'" <> str <> "\' is used ambiguously without a table or alias"
                                    else Right $ (Map.insert name False map, False, [])
                            else Left $ "In WHERE clause, column \'" <> str <> "\' is used ambiguously without a table or alias"
                        Just (src, col) -> Right $ (Map.insert src False map, False, []) -- an identifier adds a table, doesn't provoke abort, and doesn't provide selections
                P.Function id args -> case functionLookup id of 
                    Nothing -> Left $ "Function \'" <> id <> "\' not recognized"
                    Just (FunctionInfo {returnType = rt}) ->  Left $ "stil need to implement" -- if it's a boolean, I suppose it qualifies as a selection we could do
                P.Operator optype -> case optype of 
                    P.Or op1 op2 -> do 
                        (map1, _, _) <- extract_ either op1 
                        (map2, _, _) <- extract_ either op2
                        let newMap = Map.union map1 map2
                        -- return the new map, tell above expressions to abort, and save the Or expression only without any subexpressions
                        return (newMap, True, 
                                    [SelectionInfo 
                                        { tables = fmap ((flip (,)) Nothing) $ Map.keys newMap, expr = ex}
                                    ]) 
                    P.And op1 op2 -> do -- And expressions do not generate their own expressions, since the selections on lower tables automatically perform them
                        (map1, a1, s1) <- extract_ either op1
                        (map2, a2, s2) <- extract_ either op2
                        let newMap = Map.union map1 map2
                            newAbort = a1 || a2
                        if newAbort
                        then return (newMap, True, 
                                        [SelectionInfo 
                                            { tables = fmap ((flip (,)) Nothing) $ Map.keys newMap, expr = ex}
                                        ])
                        else return (newMap, False, s1 <> s2)
                    P.Equals op1 op2 -> comparison ex op1 op2 either
                    P.NotEquals op1 op2 -> comparison ex op1 op2 either
                    P.LT op1 op2 -> comparison ex op1 op2 either
                    P.LTE op1 op2 -> comparison ex op1 op2 either
                    P.GT op1 op2 -> comparison ex op1 op2 either
                    P.GTE op1 op2 -> comparison ex op1 op2 either
                    _ -> Left $ "Current operator not supported"
                _ -> Left $ "Current expression not supported"
        comparison :: P.Expr -> P.Expr -> P.Expr -> Either Error (TablesUsed, Abort, SelectionStream) -> Either Error (TablesUsed, Abort, SelectionStream)
        comparison _ _ _ either@(Left _) = either
        comparison comp op1 op2 opts@(Right (emap, abort, stream)) = do 
            (map1, a1, str1) <- extract_ (opts) op1
            (map2, a2, str2) <- extract_ (opts) op2
            let newMap = Map.union (map1) (map2)
                newAbort = a1 || a2
                etables = sequence $ fmap genTablesUsed $ Map.keys newMap
            case etables of 
                Left e -> Left e
                Right ts -> 
                    if newAbort 
                    then return (newMap, True, 
                            [ SelectionInfo 
                                { tables = ts
                                , expr = comp 
                                }
                            ])
                    else 
                        if (Map.size $ newMap) == 1 -- if the tables below only had 1 table total, we can take the entire the selection down to the table used
                        then 
                            let newStream = [SelectionInfo { tables = ts, expr = comp }]
                            in  return (newMap, abort, newStream)
                        else  -- but if there are multiple tables, then this equality comparison needs to be appended to the other selections from lower down
                            let newStream = (SelectionInfo { tables = ts, expr = comp }):(str1 <> str2)
                            in  return (newMap, abort, newStream)
        genTablesUsed :: Name -> Either Error Table
        genTablesUsed name = case Map.lookup name tmap of 
            Just multtimes ->
                if multtimes
                then Left $ "Table name \'" <> name <> "\' has been used multiple times and cannot be used to disambiguate"
                else Right (name, Nothing)
            Nothing -> case Map.lookup name amap of 
                Nothing -> Left $ "Table/alias \'" <> name <> "\' was used before being defined"
                Just table -> Right (table, Just name)



data FunctionType
    = Boolean 
    | Number 
    | String

data FunctionInfo = FunctionInfo 
    { returnType :: FunctionType

    }

functionLookup :: String -> Maybe FunctionInfo 
functionLookup str = Map.lookup (Char.toLower <$> str) functionInfo

    where 
        functionInfo :: Map.Map String FunctionInfo
        functionInfo = Map.fromList 
            [ ("plus", FunctionInfo { returnType = Number })
            , ("minus", FunctionInfo { returnType = Number})
            , ("and", FunctionInfo { returnType = Boolean })
            , ("or", FunctionInfo { returnType = Boolean} )
            ]
