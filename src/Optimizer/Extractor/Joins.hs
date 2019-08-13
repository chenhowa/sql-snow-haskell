module Optimizer.Extractor.Joins where 

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L
import qualified Data.Char as Char
import Optimizer.Extractor.Projections (tableAndColumn)

{- when joining, should the columns being joined on include the latest 
    table added to the join?
-}

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

extract :: [P.Table] -> JoinStream
extract tables = concat $ (extract_ <$> tables)
    where 
        extract_ :: P.Table -> JoinStream
        extract_ table = case table of 
            Table name malias -> []
            Join jtype t1 t2 (col1, col2) -> 
                let jInfo = JoinInfo { type_ = jtype, joinOn :: (Column, Column) }
                in  jInfo : (extract_ t1 <> extract_ t2)