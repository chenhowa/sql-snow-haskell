module Parser.Expressions where

import Parser.Syntax as S


plus :: S.Op -> S.Op -> S.Expr
plus op1 op2 = S.Operator $ S.Plus op1 op2

minus :: S.Op -> S.Op -> S.Expr
minus op1 op2 = S.Operator $ S.Minus op1 op2

divide :: S.Op -> S.Op -> S.Expr
divide op1 op2 = S.Operator $ S.FloatDivide op1 op2

modulo :: S.Op -> S.Op -> S.Expr
modulo op1 op2 = S.Operator $ S.Modulo op1 op2

multiply :: S.Op -> S.Op -> S.Expr
multiply op1 op2 = S.Operator $ S.Multiply op1 op2

equals :: S.Op -> S.Op -> S.Expr
equals op1 op2 = S.Operator $ S.Equals op1 op2

notEquals :: S.Op -> S.Op -> S.Expr
notEquals op1 op2 = S.Operator $ S.NotEquals op1 op2

lessThan :: S.Op -> S.Op -> S.Expr
lessThan op1 op2 = S.Operator $ S.LT op1 op2

lessThanOrEquals :: S.Op -> S.Op -> S.Expr
lessThanOrEquals op1 op2 = S.Operator $ S.LTE op1 op2

greaterThan :: S.Op -> S.Op -> S.Expr
greaterThan op1 op2 = S.Operator $ S.GT op1 op2

greaterThanOrEquals :: S.Op -> S.Op -> S.Expr
greaterThanOrEquals op1 op2 = S.Operator $ S.GTE op1 op2

and :: S.Op -> S.Op -> S.Expr
and op1 op2 = S.Operator $ S.And op1 op2

or :: S.Op -> S.Op -> S.Expr
or op1 op2 = S.Operator $ S.Or op1 op2

not ::  S.Op -> S.Expr
not op1 = S.Operator $ S.Not op1 

neg ::  S.Op -> S.Expr
neg op1 = S.Operator $ S.Neg op1 

boolean :: S.BooleanType -> S.Expr
boolean = S.Constant . S.Boolean

true :: S.Expr 
true = boolean S.TrueVal

false :: S.Expr
false = boolean S.FalseVal

null :: S.Expr
null = boolean S.Null

str :: String -> S.Expr
str = S.Constant . S.String

number :: String -> S.Expr
number = S.Constant . S.Number