module Optimizer.Extractor.Projections where

import qualified Optimizer.Extractor.Tables as T
import qualified Parser.Syntax as P
import qualified Data.List as L
import Parser.Validator.Expression (operatorArgs)
import qualified Data.Map.Strict as Map

type ValidProjectionInfo = Map.Map Source [Column]
type Error = String




validate :: T.ValidTableInfo -> Either Error ColumnStream -> Either Error ValidProjectionInfo
validate info either = case either of 
    Left e -> Left e
    Right cols -> foldr collect (Right $ Map.empty) cols

    collect :: T.ValidTableInfo -> (Maybe Source, Column) -> Either Error ValidProjectionInfo -> Either Error ValidProjectionInfo
    collect (tmap, amap) (msource, col) result = case result of 
        Left _ -> result
        Right pmap -> case msource of 
            Nothing -> case Map.size tmap of  -- this should be done with guards, not case
                        0 -> Left "There are no tables in the query for the column \'" <> col <> "\' to be part of"
                        1 -> let newResult = case uncons $ Map.toList tmap of 
                                    Just ((name, _), _) -> Right $ Map.insertWith (<>) name [col]
                                    Nothing -> Left "Inconsistent table count"
                             in  newResult
                        _ -> Left "There are multiple tables in the query. Column \'" <> col <> "\' must be aliased"
            Just src -> case Map.lookup src tmap of 
                Just times -> if times  -- if table has been used more than once, it should have been aliased
                              then Left $ "Table \'" <> src "\' occurs more than once in query. Its alias should be used to refer to it"
                              else Right $ Map.insertWith (<>) name [col]
                Nothing -- Then we need to look this up by alias, not table name


type ColumnStream = [(Maybe Source, Column)]
type Source = String
type Column = String

extractColumns :: P.SelectType -> Either Error ColumnStream 
extractColumns stype = case stype of 
    P.Wildcard -> Left $ "Selecting all output columns with \'*\' is currently not allowed"     
    P.Columns cols -> Right (concat (convert <$> cols))

    where 
        convert :: P.Column -> ColumnStream
        convert (P.Column expr _) = convert_ expr

        convert_ :: P.Expr -> ColumnStream
        convert_ expr = case expr of 
            P.Identifier id -> case tableAndColumn id of 
                Nothing -> [(Nothing, id)]
                Just (s, c) -> [(Just s, c)]
            P.Function _ args -> concat $ (convert_ <$> args)
            P.Operator op -> concat $ (convert_ <$> (operatorArgs op))
            _ -> []



tableAndColumn :: String -> Maybe (Source, Column)
tableAndColumn str = case L.elemIndex '.' str of 
    Nothing -> Nothing
    Just i -> 
        let split = splitAt i str 
        in Just (fst split, drop 1 $ snd split)
