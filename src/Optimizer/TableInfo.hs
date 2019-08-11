module Optimizer.TableInfo where 

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L
import qualified Optimizer.Extractor.Tables as Table
import qualified Optimizer.Extractor.Projections as Proj

data TableInfo = 
    Table
        { table :: Table
        , alias :: Alias
        , projection :: [ Column ]
        }
    deriving (Eq, Show)

type Table = String
type Alias = String
type Column = String
type Error = String

-- !! This doesn't support cross product joins!!
-- !! This still needs work to get the selection expression for this particular table, if available.

extractInfoFromQuery :: P.Query -> Either Error [TableInfo]
extractInfoFromQuery q = case q of 
    P.Select stype mfrom uniq -> case mfrom of 
        Nothing -> Right []
        Just (P.FromClause { P.tables = ts }) -> do 
            tinfo@(tmap, amap) <- Table.validate . Table.extract $ ts
            projections <- (Proj.validate tinfo) . Proj.extractFromQuery $ q
            return $ createTableInfo projections
    _ -> Left $ "Query is not a select statement"

    where
    createTableInfo :: Proj.ValidProjectionInfo -> [TableInfo]
    createTableInfo pmap = 
        let projections = Map.toList pmap
        in  (convert <$> projections)
        where 
            convert :: ((Proj.TableName, Maybe Proj.Alias), [Proj.Column]) -> TableInfo
            convert ((tname, mal), cols) = Table
                { table = tname
                , projection = cols
                , alias = case mal of 
                        Nothing -> ""
                        Just al -> al
                }

tableAndColumn :: String -> Maybe (Table, Column)
tableAndColumn str = case L.elemIndex '.' str of 
    Nothing -> Nothing
    Just i -> 
        let split = splitAt i str 
        in Just (fst split, drop 1 $ snd split)