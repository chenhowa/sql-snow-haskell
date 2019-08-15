module Optimizer.Extractor.Aggregations where

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L
import Optimizer.Extractor.Projections (tableAndColumn)
import qualified Control.Applicative as A
import qualified Optimizer.Extractor.Selections as S
import qualified Optimizer.Extractor.Tables as T

data AggInfo = AggInfo 
    { cols :: [(Source, Column)]
    , selections :: S.SelectionStream
    }
    deriving (Show, Eq)
type Error = String
type Source = String
type Column = String

extract :: T.ValidTableInfo -> P.GroupBy -> Either Error AggInfo
extract tinfo@(tmap, amap) (P.GroupBy ids mhaving) = do 
    cs <- sequence ((extractCols tinfo) <$> ids)
    ss <- case mhaving of 
        Nothing -> Right []
        Just (P.Having expr) -> S.extract tinfo expr
    Right $ AggInfo
        { cols = cs
        , selections = ss
        }
    where 
        extractCols :: T.ValidTableInfo -> String -> Either Error (Source, Column)
        extractCols (tmap, amap) id = 
            case tableAndColumn id of 
                Nothing -> 
                    if Map.size tmap == 1
                    then case L.uncons $ Map.toList tmap of 
                        Nothing -> Left $ "Unexpected: No table present"
                        Just ((table, times), _) -> 
                            if times 
                            then Left $ "In GROUP BY, column \'" <> id <> "\' is used ambiguously"
                            else Right (table, id)
                    else Left $ "In GROUP BY, column \'" <> id <> "\' is used ambiguously"
                Just pair@(source, col) -> Right pair
