module Lexer.Tokens where 

import Prelude hiding (Right, Left)

data Token
    = Select --addressed in parser
    | From --addressed in parser
    | Where  --addressed in parser
    | GroupBy --addressed in parser
    | Having --addressed in parser
    | In     -- addressed in parser
    | NotIn -- addressed in parser
    | Distinct  -- !!!!! PARTIAL (additional use with aggregate functions)
    | Limit  --addressed in parser
    | OrderBy --addressed in parser
    | Ascending  --addressed in parser
    | Descending  --addressed in parser
    | Union 
    | Intersect 
    | Any -- addressed in parser
    | All  -- !! PARTIAL (additional use with Union)
    | Exists
    | Left 
    | Right 
    | Inner 
    | Outer 
    | Natural 
    | Join 
    | On 
    | Plus  --addressed in parser
    | Minus  --addressed in parser
    | Asterisk  --addressed in parser
    | FloatDivide  --addressed in parser
    | Modulo  --addressed in parser
    | Equals  --addressed in parser
    | NotEquals  --addressed in parser
    | LT  --addressed in parser
    | LTE  --addressed in parser
    | GT  --addressed in parser
    | GTE  --addressed in parser
    | Not  --addressed in parser
    | And  --addressed in parser
    | Or  --addressed in parser
    | As  --addressed in parser
    | Identifier String --addressed in parser
    | Dotwalk String --addressed in parser
    | RightParen  --addressed in parser
    | LeftParen  --addressed in parser
    | Comma  --addressed in parser
    | BlockComment String
    | Integer String -- addressed in parser
    | Float String -- addressed in parser
    | String String -- addressed in parser
    | TrueVal -- addressed in parser
    | FalseVal -- addressed in parser
    | Null -- addressed in parser
    deriving (Eq, Show)
