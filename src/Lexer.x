{ 
module Lexer 
    ( alexScanTokens
        
    ) where

import Lexer.Tokens as T
}

%wrapper "basic"


$digit              = 0-9
$alpha              = [a-zA-Z]
$alphanum           = [a-zA-Z0-9]
$underscore         = _
$idchar             = [a-zA-Z0-9_]

@ident              = $alpha ($idchar)*
@dotwalk            = @ident (\. @ident)+
@blockcomment       = "/*" .* "*/"

@integer            = $digit+
@float              = @integer \. @integer
@string             = (\" .* \") | (\' .* \')

tokens :-

    $white+                                         ;
    "+"                                             { \s -> T.Plus }
    "-"                                             { \s -> T.Minus }
    "*"                                             { \s -> T.Asterisk }
    "/"                                             { \s -> T.FloatDivide }
    "%"                                             { \s -> T.Modulo }
    "<"                                             { \s -> T.LT }
    "<="                                            { \s -> T.LTE }
    ">"                                             { \s -> T.GT }
    ">="                                            { \s -> T.GTE }
    "="                                             { \s -> T.Equals }
    "!="                                            { \s -> T.NotEquals }
    ","                                             { \s -> T.Comma } 
    "("                                             { \s -> T.LeftParen }
    ")"                                             { \s -> T.RightParen }
    SELECT | select                                 { \s -> T.Select }
    FROM | from                                     { \s -> T.From }
    WHERE | where                                   { \s -> T.Where }
    "GROUP" $white+ "BY" | "group" $white+ "by"     { \s -> T.GroupBy }
    HAVING | having                                 { \s -> T.Having }
    IN | in                                         { \s -> T.In }
    "NOT" $white+ "IN" | "not" $white+ "in"         { \s -> T.NotIn } 
    DISTINCT | distinct                             { \s -> T.Distinct }
    LIMIT | limit                                   { \s -> T.Limit }
    "ORDER" $white+ "BY" | "order" $white+ "by"     { \s -> T.OrderBy }
    ASC | asc                                       { \s -> T.Ascending }
    DESC | desc                                     { \s -> T.Descending }
    UNION | union                                   { \s -> T.Union }
    INTERSECT | intersect                           { \s -> T.Intersect }
    ALL | all                                       { \s -> T.All }
    ANY | any                                       { \s -> T.Any }
    EXISTS | exists                                 { \s -> T.Exists }
    LEFT | left                                     { \s -> T.Left }
    RIGHT | right                                   { \s -> T.Right }
    INNER | inner                                   { \s -> T.Inner }
    OUTER | outer                                   { \s -> T.Outer }
    NATURAL | natural                               { \s -> T.Natural }
    JOIN | join                                     { \s -> T.Join }
    ON | on                                         { \s -> T.On }
    NOT | not                                       { \s -> T.Not }
    AND | and                                       { \s -> T.And }
    OR | or                                         { \s -> T.Or }
    AS | as                                         { \s -> T.As }
    TRUE | true                                     { \s -> T.TrueVal }
    FALSE | false                                   { \s -> T.FalseVal  }
    NULL | null                                     { \s -> T.Null  }
    @blockcomment                                   { \s -> T.BlockComment $ (removeFirstLast 2 s) }
    @integer                                        { \s -> T.Integer s }
    @float                                          { \s -> T.Float s }
    @string                                         { \s -> T.String (removeFirstLast 1 s) }
    @dotwalk                                        { \s -> T.Dotwalk s }
    @ident                                          { \s -> T.Identifier s }
    
    
{
removeFirstLast :: Int -> [ a ] -> [ a ]
removeFirstLast int = reverse . drop int . reverse . drop int
}