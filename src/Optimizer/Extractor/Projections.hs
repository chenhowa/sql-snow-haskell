module Optimizer.Extractor.Projections where

import qualified Optimizer.Extractor.Tables as T
import qualified Parser.Syntax as P
import qualified Data.List as L
import Parser.Validator.Expression (operatorArgs)

type ValidProjectionInfo = String
type Error = String


validate :: Either Error ColumnStream -> Either Error ValidProjectionInfo
validate either = undefined


type ColumnStream = [(Maybe Source, Column)]
type Source = String
type Column = String

extractColumns :: T.ValidTableInfo -> P.SelectType -> Either Error ColumnStream 
extractColumns info stype = case stype of 
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
