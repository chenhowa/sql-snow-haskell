module Lexer.Tokens where 

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
    | Constant String 
    | RightParen 
    | LeftParen 
    | Comma 
    | LineComment String
    | BlockComment String
    | Constant Constant

data Constant 
    = Integer String
    | Float String 
    | String String 
    | Boolean Bool

data Bool 
    = True 
    | False 
    | Null