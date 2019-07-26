{ 
module Lexer 
    ( alexScanTokens
        
    ) where

import Lexer.Token
import Lexer.Token as T
}

%wrapper "basic"


$digit              = 0-9
$alpha              = [a-zA-Z]
$alphanum           = [$digit$alpha]
$underscore         = _
$idchar             = [$underscore$alphanum]

@identifier         = $alpha (idchar)*
@dotwalk            = @identifier (\. @identifier)+
@linecomment        = "--" ($white # [\n])* [\n]
@blockcomment       = "/*" .* "*/"

@integer            = $digit+
@float              = @integer \. @integer
@string             = (\" .* \") | (\' .* \')

tokens :-

    $white+                                         ;
    "+"                                             { \s -> Plus }
    "-"                                             { \s -> Minus }
    "*"                                             { \s -> Asterisk }
    "/"                                             { \s -> FloatDivide }
    "%"                                             { \s -> Modulo }
    "<"                                             { \s -> T.LT }
    "<="                                            { \s -> T.LTE }
    ">"                                             { \s -> T.GT }
    ">="                                            { \s -> T.GTE }
    "="                                             { \s -> Equals }
    "!="                                            { \s -> NotEquals }
    ","                                             { \s -> Comma } 
    "("                                             { \s -> RightParen }
    ")"                                             { \s -> LeftParen }
    SELECT | select                                 { \s -> Select }
    FROM | from                                     { \s -> From }
    WHERE | where                                   { \s -> Where }
    "GROUP BY" | "group by"                         { \s -> GroupBy }
    HAVING | having                                 { \s -> Having }
    IN | in                                         { \s -> In }
    DISTINCT | distinct                             { \s -> Distinct }
    LIMIT | limit                                   { \s -> Limit }
    "ORDER BY" | "order by"                         { \s -> OrderBy }
    ASC | asc                                       { \s -> Ascending }
    DESC | desc                                     { \s -> Descending }
    UNION | union                                   { \s -> Union }
    INTERSECT | intersect                           { \s -> Intersect }
    ALL | all                                       { \s -> All }
    LEFT | left                                     { \s -> Left }
    RIGHT | right                                   { \s -> Right }
    INNER | inner                                   { \s -> Inner }
    OUTER | outer                                   { \s -> Outer }
    NATURAL | natural                               { \s -> Natural }
    JOIN | join                                     { \s -> Join }
    ON | on                                         { \s -> On }
    NOT | not                                       { \s -> Not }
    AND | and                                       { \s -> And }
    OR | or                                         { \s -> Or }
    AS | as                                         { \s -> As }
    @identifier                                     { \s -> Identifier s }
    @linecomment                                    { \s -> LineComment $ removeFirstLast s }
    @blockcomment                                   { \s -> BlockComment $ removeFirstLast s }
    @integer                                        { \s -> Constant $ T.Integer s }
    @float                                          { \s -> Constant $ T.Float s }
    @string                                         { \s -> Constant $ T.String (removeFirstLast s) }
    TRUE | true                                     { \s -> Constant $ T.Boolean T.True }
    FALSE | false                                   { \s -> Constant $ T.Boolean T.False  }
    NULL | null                                     { \s -> Constant $ T.Boolean T.Null  }
    
{
removeFirstLast :: [ a ] -> [ a ]
removeFirstLast = drop 1 . reverse . drop 1
}