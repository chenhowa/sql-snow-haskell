module Optimizer.JoinInfo where 

import Prelude
import qualified Parser.Syntax as P

data JoinInfo = 
    Join
        { table1 :: String
        , table2 :: String
        , onCondition :: JoinCondition
        , joinType :: JoinType
        }
    deriving (Eq, Show)

data JoinType
    = Inner
    | LeftOuter 
    | RightOuter
    | FullOuter
    | Natural
    deriving (Eq, Show)

extractQueryInfo :: P.Query -> [JoinInfo]
extractQueryInfo q = case q of 
    P.Select _ mfrom _ ->  case mfrom of 
        Nothing -> []
        Just from -> extractFromInfo from
    _ -> []

extractFromInfo :: P.FromClause -> [JoinInfo]
extractFromInfo (P.FromClause ts w _ _ _) = 
    let tInfo = extractInfoTables ts
        wInfo = extractInfoWhere ws
    in  CONCAT ?? [ tinfo wInfo ]

extractInfoTables :: [ P.Table ] -> [ JoinInfo ]
extractInfoTables tables = concat $ (extractInfoTable <$> tables)
    where 
        extractInfoTable :: P.Table -> [JoinInfo]
        extractInfoTable t = case t of 
            P.Table _ _ -> [] 
            P.Natural t1 t2 -> CONCAT ?? [extractInfoTable t1, extractInfoTable t2]
            P.Join jtype t1 t2 cols -> CONCAT ?? [extractInfoTable t1, extractInfoTable t2] 

extractInfoWhere :: Maybe P.Where -> [JoinInfo]
extractInfoWhere mw = case mw of 
    Nothing -> []
    Just w -> extractInfo w
    where 
        extractInfo :: P.Where -> [JoinInfo]
        extractInfo w = 
            let firstLevelComparisons :: [P.Operator]
                firstLevelComparisons = case w of 
                    P.Operator optype -> 
                        case opType of 
                            P.And op1 op2 -> [operators op1] <> (extractInfo op2)
                            P.Or op1 op2 -> [operators op1] <> (extractInfo operators op2)
                            P.Not op -> [operators op]
                            P.Equals op1 op2 -> [w]
                            P.NotEquals op1 op2 -> [w]
                            P.LT op1 op2 -> [w]
                            P.LTE op1 op2 -> [w]
                            P.GT op1 op2 -> [w]
                            P.GTE op1 op2 -> [w]
                            _ -> []
                    _ -> []
                
                comparisonOperators :: P.OperatorType
                comparisonOperators = case w of 
                    P.Operator opType -> case opType of 
                        P.Equals op op -> [op, op]
                        P.NotEquals op op -> [op, op]
                        P.LT op op -> [op, op]
                        P.LTE op op -> [op, op]
                        P.GT op op -> [op, op]
                        P.GTE op op -> [op, op]
            _ -> [] 

{- FROM incident I, problem P   -- this already ensures that we will do a cross product
   WHERe I.number = P.number AND LEN(I.number + P.number) > 7

   because you can't run user-defined functions on queries and materialize the result,
   you are forced to use chunk-nested loops join 
   and then filter the cross product.

   BUt I WANT TO EXTRACT BOTH AS JOIN CONDITIONS, if we interpret join conditions as Cross Product x filter
-}

        splitBoolean :: P.Expr -> [ P.Expr ]
        splitBoolean expr = case expr of 
            P.Operator 
            _ -> expr
