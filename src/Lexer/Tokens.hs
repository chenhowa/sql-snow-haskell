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
    | Identifier IdentifierType 
    | RightParen 
    | LeftParen 
    | Comma 
    | LineComment String
    | BlockComment String
    | Constant ConstantType

data ConstantType 
    = Integer String
    | Float String 
    | String String 
    | Boolean BooleanType

data BooleanType
    = True 
    | False 
    | Null

data IdentifierType 
    = Simple String
    | Dotwalk String