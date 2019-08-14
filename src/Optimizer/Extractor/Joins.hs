module Optimizer.Extractor.Joins where 

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L
import qualified Data.Char as Char
import Optimizer.Extractor.Projections (tableAndColumn)
import qualified Control.Applicative as A

{- !! when joining, should the columns being joined on include the latest 
    table added to the join?
-}

{- We will join all tables. The JoinInfo simply provides more information on the more difficult joins that don't 
    conform to simple selections, like outer joins.
-}
type Error = String
type JoinStream = [JoinInfo]
type Name = String
type Alias = String 
type Source = String
type ColName = String
type Column = (Source, ColName)
data JoinInfo
    = JoinInfo
        { type_ :: P.JoinType 
        , joinOn :: (Column, Column)
        }
    deriving (Eq, Show)

extract :: [P.Table] -> Either Error JoinStream
extract tables = concat <$> (sequence (extract_ <$> tables))
    where 
        extract_ :: P.Table -> Either Error JoinStream
        extract_ table = case table of 
            P.Table name malias -> Right []
            P.Join jtype t1 t2 (col1, col2) -> 
                let c1 = case tableAndColumn col1 of 
                        Nothing -> Left $ "In join, column \'" <> col1 <> "\' is not qualified with a table/alias"
                        Just (t, c) -> Right (t, c)
                    c2 = case tableAndColumn col2 of 
                        Nothing -> Left $ "In join, column \'" <> col2 <> "\' is not qualified with a table/alias"
                        Just (t, c) -> Right (t, c)
                in do 
                    source1 <- c1
                    source2 <- c2
                    let jInfo = JoinInfo { type_ = jtype, joinOn = (source1, source2) }
                    ((<>) [jInfo]) <$> (A.liftA2 (<>) (extract_ t1) (extract_ t2))