module Optimizer.JoinInfo where 

import qualified Parser.Syntax as P
import qualified Optimizer.TableInfo as T

data JoinInfo
    = Join
        { table1 :: String
        , table2 :: String
        , onCondition :: JoinCondition
        , joinType :: P.JoinType
        }
    | CrossProduct Table
    deriving (Eq, Show)

type Table = String
type Column = String

data JoinCondition 
    = Equals (Table, Column) (Table, Column)
    deriving (Eq, Show)

{-
What operators are allowed in a JOIN ON search expression? Start with '=' between two identifiers,
and that's it...

Arbitrarily nested expressions can be allowed in the output columns, but NOT NECESARILY in the WHERE clause.
For the WHERE clause, the simplest thing to do would be to just turn it into a giant selection at the end.
Trying to devise a scheme where we always push the selections down to the right place ... is difficult. If there is just
one table in a condition, we can push it down to that table. If there are two tables in a condition,
we can push it down to the JOIN between those two tables. So basically we need to try to apply the condition
at the soonest point in the query plan where all the tables are in the query plan.

If there is an OR, like "category > 5 AND state > 3 OR state < 3", then this can just be a selection on one table.
But if we have "i.category > 5 AND i.state > 3 OR p.state < 3", then either we have to run the query twice,
apply one side of the OR, and then UNION that with running the query again with the other side of the OR, 
or the entire statement becomes a Selection after incident and problem have been joined.

Instead of publishing each field directly on a tuple, we might namespace the tuple as follows

var tuple = 
    { incident: 
        { getValue: function('')

        }
    , problem:
        { getValue: function('')

        }
    , tables: ['incident', 'problem']
    , getValue: function(str) {
        if in both, return object, 
            return {
                incident: val
                problem: val
            }
            
        else just return the value
            
      }
    }

    Natural join makes it hard to know what you're joining, whose meaning very much differs
    based on where it is in the query plan.
-}

{- FROM incident I, problem P   -- this already ensures that we will do a cross product
   WHERe I.number = P.number AND LEN(I.number + P.number) > 7

   because you can't run user-defined functions on queries and materialize the result,
   you are forced to use chunk-nested loops join 
   and then filter the cross product.

   BUt I WANT TO EXTRACT BOTH AS JOIN CONDITIONS, if we interpret join conditions as Cross Product x filter
-}

extractQueryInfo :: P.Query -> [JoinInfo]
extractQueryInfo q = case q of 
    P.Select _ mfrom _ ->  case mfrom of 
        Nothing -> []
        Just from -> extractFromInfo from
    _ -> []

extractFromInfo :: P.FromClause -> [JoinInfo]
extractFromInfo (P.FromClause ts w _ _ _) = 
    let tInfo = extractInfoTables ts
    in  tInfo

extractInfoTables :: [ P.Table ] -> [ JoinInfo ]
extractInfoTables tables = concat $ (extractInfoTable <$> tables)
    where 
        extractInfoTable :: P.Table -> [JoinInfo]
        extractInfoTable t = case t of 
            P.Table _ _ -> [] 
            P.Join jtype t1 t2 cols -> (extract jtype cols) <> ( concat [extractInfoTable t1, extractInfoTable t2] )
        extract :: P.JoinType -> (String, String) -> [ JoinInfo ]
        extract jtype (cond1, cond2) = 
            let m1 = T.tableAndColumn cond1
                m2 = T.tableAndColumn cond2
            in  case m1 of 
                    Nothing -> []
                    Just r1@(t1, c1) -> 
                        case m2 of 
                            Nothing -> []
                            Just r2@(t2, c2) -> 
                                [ Join 
                                    { table1 = t1
                                    , table2 = t2
                                    , onCondition = Equals r1 r2
                                    , joinType = jtype
                                    }
                                ]


