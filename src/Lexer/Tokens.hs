module Lexer.Tokens where 

import Prelude hiding (Right, Left)

data Token
    = Select
    | From
    | Where 
    | GroupBy
    | Having
    | In 
    | Distinct 
    | Limit 
    | OrderBy
    | Ascending 
    | Descending 
    | Union 
    | Intersect 
    | All 
    | Left 
    | Right 
    | Inner 
    | Outer 
    | Natural 
    | Join 
    | On 
    | Plus 
    | Minus 
    | Asterisk 
    | FloatDivide 
    | Modulo 
    | Equals 
    | NotEquals 
    | LT 
    | LTE 
    | GT 
    | GTE 
    | Not 
    | And 
    | Or 
    | As 
    | Identifier String
    | Dotwalk String
    | RightParen 
    | LeftParen 
    | Comma 
    | BlockComment String
    | Constant ConstantType
    deriving (Eq, Show)

data ConstantType 
    = Integer String
    | Float String 
    | String String 
    | Boolean BooleanType
    deriving (Eq, Show)

data BooleanType
    = TrueVal
    | FalseVal
    | Null
    deriving (Eq, Show)