module Lexer.Tokens where 

data Token
    = TokenSelect
    | TokenFrom
    | TokenWhere 
    | TokenGroupBy
    | TokenHaving
    | TokenIn 
    | TokenDistinct 
    | TokenLimit 
    | TokenOrderBy
    | TokenAscending 
    | TokenDescending 
    | TokenUnion 
    | TokenIntersect 
    | TokenAll 
    | TokenLeft 
    | TokenRight 
    | TokenInner 
    | TokenOuter 
    | TokenNatural 
    | TokenJoin 
    | TokenOn 
    | TokenPlus 
    | TokenMinus 
    | TokenAsterisk 
    | TokenFloatDivide 
    | TokenModulo 
    | TokenEquals 
    | TokenNotEquals 
    | TokenLT 
    | TokenLTE 
    | TokenGT 
    | TokenGTE 
    | TokenNot 
    | TokenAnd 
    | TokenOr 
    | TokenAs 
    | TokenIdentifier String 
    | TokenConstant String 
    | TokenRightParen 
    | TokenLeftParen 
    | TokenComma 
    | TokenLineComment String
    | TokenBlockComment String