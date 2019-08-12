module Optimizer.Extractor.Selections where

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L
import qualified Data.Char as Char

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
    deriving (Eq, Show)

type Table = (Name, Maybe Alias)
type Name = String
type Alias = String
type Error = String

type TablesUsed = Map.Map Name Bool

-- extract goes down into a where statement and generates a list of all selections that need to be done
-- on the tables, where we try to push all selections as far down as possible
extract :: P.Where -> Either Error SelectionStream
extract wh = 
    let m = extract_ (Right Map.empty) wh
    in  Right []

    where 
        extract_ :: Either Error TablesUsed -> P.Where -> Either Error TablesUsed
        extract_ emap w = do 
            map <- emap 
            case w of 
                P.Constant _ -> Right $ map -- Finding a constant doesn't alter the map of tables that have been seen at all
                P.Identifier str -> Right $ Map.insert str False map -- finding an identifier, we tell the caller that we've found another table
                P.Function id args -> case functionLookup id of 
                    Nothing -> Left $ "Function \'" <> id <> "\' not recognized"
                    Just (FunctionInfo {returnType = rt}) ->  Left $ "stil need to implement" -- if it's a boolean, I suppose it qualifies as a selection we could do
                P.Operator optype -> case optype of 
                    P.Or op1 op2 -> 
                    P.And op1 op2 -> 
                    P.Equals op1 op2 -> do 
                        tables1 <- extract_ op1
                        tables2 <- extract_ op2
                        if (Map.size $ Map.union tables1 tables2) == 1 -- if there is only one table used, we can move the selection down to the table used
                        then 
                        else 
                    P.NotEquals op1 op2 -> 
                    P.LT op1 op2 -> 
                    P.LTE op1 op2 -> 
                    P.GT op1 op2 -> 
                    P.GTE op1 op2 -> 
                    _ -> Left $ "Current operator not supported"
                _ -> Left $ "Current expression not supported"


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
