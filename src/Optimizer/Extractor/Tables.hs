module Optimizer.Extractor.Tables where

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L


{-  Desired error detection:

1. Across multiple tables, the same alias is not used twice
2. Within a nested joins table, a table that occurs twice must be aliased BOTH TIMES
3. Within a nested joins table, the tables used in an ON clause must have been already earlier in the nested joins table
4. Within a nested joins table, the same alias is not used twice.

    Desired knowledge

1. If a single table occurs twice. In that case, we can see whether ambiguous table references occur 
    elsewhere in the query
-}

type ValidTableInfo = ( TableMap, AliasMap )
type TableMap = Map.Map TableName MultipleTimes
type MultipleTimes = Bool
type AliasMap = Map.Map Alias TableName
type Error = String
type JoinTableInfo = TableMap

type JoinAliasCount = Map.Map TableName (TableOccurences, AliasCount)
type TableOccurences = Int 
type AliasCount = Int

validate :: TableExtraction -> Either Error ValidTableInfo
validate (TableExtraction { tables = ts }) = 
    let empty = Right (Map.empty, Map.empty)
        either = foldr validate_ empty ts
    in  case either of 
            Left _ -> either 
            Right info -> case aliasTableConflict info of 
                Just e -> Left e 
                Nothing -> either
    where 
        validate_ :: Table -> Either Error ValidTableInfo -> Either Error ValidTableInfo
        validate_ tab either = case either of 
            Left _ -> either
            Right info@(tmap, amap) -> case L.uncons tab of 
                Nothing -> either
                Just ((name, malias), rest) -> 
                    if null rest -- then we are in single table case
                    then case malias of 
                            Nothing -> case Map.lookup name tmap of 
                                    Nothing -> Right (Map.insert name False tmap, amap) -- we note that we've seen this table for the first time
                                    Just times -> Right (Map.insert name True tmap, amap) -- we note that we've seen this table more than once, no new aliases
                            Just alias -> case Map.lookup alias amap of 
                                    Just _ -> Left $ "Alias \'" <> alias <> "\' has been used multiple times" -- can never re-use aliases
                                    Nothing -> 
                                        let newAliasMap = Map.insert alias name amap
                                        in case Map.lookup name tmap of 
                                            Nothing -> Right (Map.insert name False tmap, newAliasMap) -- seen table for first time with a new alias to disambiguate
                                            Just times -> Right (Map.insert name True tmap, newAliasMap) -- seen this table more than once, with a new alias to disambiguate
                    else -- we are in multi table join case
                        let merror = checkError $ foldr count Map.empty tab
                        in  case merror of 
                                Just err -> Left err
                                Nothing ->
                                    case foldr validateJoin (Right $ (info, Map.empty) ) tab of 
                                        err@(Left message) -> Left message
                                        Right(i, j) -> Right i
        aliasTableConflict :: ValidTableInfo -> Maybe Error 
        aliasTableConflict (tmap, amap) = 
            let inter = Map.intersection tmap amap
            in 
                if 0 == Map.size inter
                then Nothing 
                else Just $ case L.uncons $ Map.toList inter of 
                        Nothing -> "Alias should not have the same name as a table"
                        Just ((name, _), _) -> "Table name \'" <> name <> "\' cannot be used as an alias"

        count :: (TableName, Maybe Alias) -> JoinAliasCount -> JoinAliasCount
        count (name, malias) m = case Map.lookup name m of 
            Nothing -> case malias of 
                Nothing -> Map.insert name (1, 0) m
                Just alias -> Map.insert name (1, 1) m
            Just (times, count) -> case malias of 
                Nothing -> Map.insert name (times + 1, count)  m
                Just alias -> Map.insert name (times + 1, count + 1) m
        checkError :: JoinAliasCount -> Maybe Error
        checkError m = 
            let notAliasedEnough = \tup -> (fst tup /= snd tup) && (fst tup > 1)
                errors = Map.toList $ Map.filter notAliasedEnough m
            in case L.uncons errors of 
                Just ((table, _), _) -> Just $ "Ambiguous use of \'" <> table <> "\' in join. Please alias all occurences in the join"
                Nothing -> Nothing
        
        validateJoin :: (TableName, Maybe Alias) -> Either Error (ValidTableInfo, JoinTableInfo) -> Either Error (ValidTableInfo, JoinTableInfo)
        validateJoin (name, malias) either = case either of 
            Left _ -> either
            Right ((vtmap, vamap), jtmap) -> case malias of 
                Nothing -> case Map.lookup name jtmap of 
                        Just _ -> Left $ "Table \'" <> name <> "\' has been used multiple times ambiguously (no aliases) in the join statement"
                        Nothing -> 
                            let newJtmap = Map.insert name False jtmap -- seen this table once in join statement, no aliases
                            in  case Map.lookup name vtmap of 
                                    Nothing -> 
                                        let newVtmap = Map.insert name False vtmap
                                        in Right ((newVtmap, vamap), newJtmap) -- we note we've seen this table for first time in most global and local map
                                    Just times -> 
                                        let newVtmap = Map.insert name True vtmap
                                        in Right ((newVtmap, vamap), newJtmap) -- seen table twice globally, just once locally.
                Just alias -> case Map.lookup alias vamap of 
                        Just _ -> Left $ "Alias \'" <> alias <> "\' has been used multiple times" -- can never re-use aliases
                        Nothing ->
                            let newVamap = Map.insert alias name vamap
                            in  case Map.lookup name jtmap of -- has this table been seen in the join statement before? 
                                    Nothing ->                                             
                                        let newJtMap = Map.insert name False jtmap
                                        in  case Map.lookup name vtmap of  -- has this table been seen at all before?
                                                Nothing -> Right ((Map.insert name False vtmap , newVamap), newJtMap)
                                                Just _ -> Right ((Map.insert name True vtmap, newVamap), newJtMap)
                                    Just (times) -> 
                                        let newJtMap = Map.insert name True jtmap
                                        in  case Map.lookup name vtmap of -- has this table been seen at all before?
                                                Nothing -> Right ((Map.insert name False vtmap, newVamap), newJtMap)
                                                Just _ -> Right ((Map.insert name True vtmap, newVamap), newJtMap)


data TableExtraction = TableExtraction
    { tables :: TableStream
    }
    deriving (Eq, Show)

type TableStream = [Table]
type Table = [(TableName, Maybe Alias)]
type TableName = String
type Alias = String

extract :: [ P.Table ] -> TableExtraction
extract tables = 
    let ts = foldr extractTable [] tables 
    in  TableExtraction { tables = ts }
    where 
        extractTable :: P.Table -> TableStream -> TableStream 
        extractTable t stream = case t of 
            P.Table id malias -> [(id, malias)] : stream
            P.Join _ t1 t2 _ -> ((extractJoin t1) <> (extractJoin t2)) : stream
extractJoin :: P.Table -> Table
extractJoin j = case j of 
    P.Table id malias -> [(id, malias)]
    P.Join _ t1 t2 _ -> extractJoin t1 <> extractJoin t2