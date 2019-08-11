module Optimizer.Extractor.Projections where

import qualified Optimizer.Extractor.Tables as T
import qualified Parser.Syntax as P
import qualified Data.List as L
import Parser.Validator.Expression (operatorArgs)
import qualified Data.Map.Strict as Map
import qualified Control.Applicative as A 

type ValidProjectionInfo = Map.Map (TableName, Maybe Alias) [Column]
type TableName = String
type Alias = String
type Error = String




validate :: T.ValidTableInfo -> Either Error ColumnStream -> Either Error ValidProjectionInfo
validate info either = case either of 
    Left e -> Left e
    Right cols -> 
        let eitherMap = foldr (collect info) (Right $ Map.empty) cols
        in  case eitherMap of 
                Left _ -> eitherMap 
                Right map -> Right $ Map.map L.nub map 

    where 
        collect :: T.ValidTableInfo -> (Maybe Source, Column) -> Either Error ValidProjectionInfo -> Either Error ValidProjectionInfo
        collect (tmap, amap) (msource, col) result = case result of 
            Left _ -> result
            Right pmap -> case msource of 
                Nothing -> 
                    let size = Map.size tmap 
                    in  case () of 
                          _ | size == 0 -> Left $ "There are no tables in the query for the column \'" <> col <> "\' to be part of"
                            | size == 1 -> let newResult = case L.uncons $ Map.toList tmap of 
                                                    Just ((name, _), _) -> Right $ Map.insertWith (<>) (name, Nothing) [col] pmap
                                                    Nothing -> Left $ "Inconsistent table count"
                                           in  newResult
                            | otherwise -> Left $ "There are multiple tables in the query. Column \'" <> col <> "\' must be aliased"
                Just src -> 
                    case Map.lookup src tmap of 
                        Just times -> if times  -- if table has been used more than once, it should have been aliased here
                                    then Left $ "Table \'" <> src <> "\' occurs more than once in query. Its alias should be used to refer to it"
                                    else  -- if table has been used only once, we can use the tablename to refer to it. It may or may not have an alias
                                        let aliasesForTable = Map.toList $ Map.filter ((==) src) amap
                                        in  case L.uncons aliasesForTable of 
                                                Nothing -> Right $ Map.insertWith (<>) (src, Nothing) [col] pmap 
                                                Just ((alias, _), _) -> Right $ Map.insertWith (<>) (src, Just alias) [col] pmap
                        Nothing -> case Map.lookup src amap of 
                            Nothing -> Left $ "\'" <> src <> "\' is not a known table or alias"
                            Just tname -> Right $ Map.insertWith (<>) (tname, Just src) [col] pmap

type ColumnStream = [ColumnInfo]
type ColumnInfo = (Maybe Source, Column)
type Source = String
type Column = String

extractFromQuery :: P.Query -> Either Error ColumnStream 
extractFromQuery q = case q of 
    P.Select stype mfrom uniq -> do 
        outputCols <- extractFromColumns stype
        fromCols <- case mfrom of 
            Nothing -> Right []
            Just (P.FromClause {P.tables = ts, P.where_ = mw, P.groupBy = mgb, P.orderBy = mob}) -> do 
                joinCols <- extractFromTables ts
                whereCols <- case mw of 
                    Nothing -> Right []
                    Just w -> Right $ extractFromCondition w
                gbCols <- case mgb of 
                    Nothing -> Right [] 
                    Just gb -> Right $ extractFromAggregation gb
                obCols <- case mob of 
                    Nothing -> Right []
                    Just ob -> extractFromOrdering ob
                return $ concat [joinCols, whereCols, gbCols, obCols]
        return $ concat [outputCols, fromCols]
    _ -> Left $ "Not a select query. Cannot extract columns"

extractFromColumns :: P.SelectType -> Either Error ColumnStream 
extractFromColumns stype = case stype of 
    P.Wildcard -> Left $ "Selecting all output columns with \'*\' is currently not allowed"     
    P.Columns cols -> Right (concat (convert <$> cols))

    where 
        convert :: P.Column -> ColumnStream
        convert (P.Column expr _) = extractFromExpr expr


extractFromTables :: [P.Table] -> Either Error ColumnStream 
extractFromTables tables = 
    let cs = foldr1 (A.liftA2 (<>)) (convert <$> tables)
    in  cs
    where 
        convert :: P.Table -> Either Error ColumnStream
        convert t = 
            case t of 
                    P.Table _ _ -> Right []
                    P.Join _ t1 t2 oncolumns -> do 
                        _ <- validateJoin Map.empty t
                        colstream <- foldr1 (A.liftA2 (<>)) [ convert t1, convert t2, Right $ convert_ oncolumns ]
                        return colstream

        convert_ :: (String, String) -> ColumnStream
        convert_ (on1, on2) = 
            let s1 = c on1
                s2 = c on2
            in  s1 <> s2
            where 
                c :: String -> ColumnStream
                c str = case tableAndColumn str of 
                    Nothing -> [(Nothing, str)]
                    Just (src, col) -> [(Just src, col)]

        validateJoin :: Map.Map String Bool -> P.Table -> Either Error (Map.Map String Bool)
        validateJoin map t = case t of 
            P.Table id malias -> Right $ Map.insert id False $ case malias of 
                Nothing -> map
                Just alias -> Map.insert alias False map
            P.Join _ t1 t2 (on1, on2) -> do 
                m <- A.liftA2 Map.union (validateJoin Map.empty t1) (validateJoin Map.empty t2)
                _ <- case tableAndColumn on1 of 
                    Nothing -> Left $ "In join, column \'" <> on1 <> "\' should have an alias to disambiguate it"
                    Just (src, col) -> case Map.lookup src m of 
                        Nothing -> Left $ "In join, alias \'" <> src <> "\' is used before being defined"
                        Just _ -> Right m
                return m
                

extractFromCondition :: P.Where -> ColumnStream 
extractFromCondition w = extractFromExpr w

extractFromOrdering :: P.OrderBy -> Either Error ColumnStream
extractFromOrdering _ = Left $ "Order by expressions are currently disallowed"

extractFromAggregation :: P.GroupBy -> ColumnStream 
extractFromAggregation (P.GroupBy ids mhaving) = 
    let idstream = map extract ids 
        havingStream = case mhaving of 
            Nothing -> []
            Just (P.Having expr) -> extractFromExpr expr
    in idstream <> havingStream
    where 
        extract :: String -> ColumnInfo
        extract str = case tableAndColumn str of 
            Nothing -> (Nothing, str) 
            Just (src, col) -> (Just src, col)

extractFromExpr :: P.Expr -> ColumnStream
extractFromExpr expr = case expr of 
    P.Identifier id -> case tableAndColumn id of 
        Nothing -> [(Nothing, id)]
        Just (s, c) -> [(Just s, c)]
    P.Function _ args -> concat $ (extractFromExpr <$> args)
    P.Operator op -> concat $ (extractFromExpr <$> (operatorArgs op))
    _ -> []

-- We want to validate here whether the columns occur at the right time with respect to the 
-- table streams in the join

pair :: [a] -> [(a, a)]
pair [] = []
pair stuff = 
    let mp = do 
            (first, rest) <- L.uncons (take 2 stuff)
            (second, _) <- L.uncons rest
            return (first, second)
        morestuff = pair (drop 2 stuff)
    in  case mp of
            Nothing -> morestuff
            Just p -> p : morestuff


tableAndColumn :: String -> Maybe (Source, Column)
tableAndColumn str = case L.elemIndex '.' str of 
    Nothing -> Nothing
    Just i -> 
        let split = splitAt i str 
        in Just (fst split, drop 1 $ snd split)
