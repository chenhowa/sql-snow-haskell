{
module Parser 
    ( parse

    ) where

import Parser.Syntax as S
import Lexer.Tokens as T


}

%name parse
%tokentype { Tok }
%error { parseError }

%token
    select                      { T.Select }
    from                        { T.From }
    where                       { T.Where }
    groupBy                     { T.GroupBy }
    having                      { T.Having }
    in                          { T.In }
    notIn                       { T.NotIn }
    distinct                    { T.Distinct }
    limit                       { T.Limit }
    orderBy                     { T.OrderBy }
    ascending                   { T.Ascending }
    descending                  { T.Descending }
    union                       { T.Union }
    intersect                   { T.Intersect }
    all                         { T.All }
    any                         { T.Any }
    left                        { T.Left }
    right                       { T.Right }
    inner                       { T.Inner }
    outer                       { T.Outer }
    natural                     { T.Natural }
    join                        { T.Join }
    on                          { T.On }
    '+'                         { T.Plus }
    '-'                         { T.Minus }
    '*'                         { T.Asterisk }
    '/'                         { T.FloatDivide }
    '%'                         { T.Modulo }
    '='                         { T.Equals }
    '!='                        { T.NotEquals }
    '<'                         { T.LT }
    '<='                        { T.LTE }
    '>'                         { T.GT }
    '>='                        { T.GTE }
    not                         { T.Not }
    and                         { T.And }
    or                          { T.Or }
    as                          { T.As }
    identifier                  { T.Identifier $$ }
    '('                         { T.LeftParen }
    ')'                         { T.RightParen }
    ','                         { T.Comma }
    bc                          { T.BlockComment $$ }
    dotwalk                     { T.Dotwalk $$ }
    integer                     { (T.Integer $$) }
    float                       { (T.Float $$) }
    string                      { (T.String $$) }
    true                        { (T.TrueVal) }
    false                       { (T.FalseVal) }
    null                        { (T.Null ) }

%left or
%left and
%left not
%nonassoc '=' '!=' '<' '<=' '>' '>='
%left '+' '-'
%left '*' '/' '%'
%left NEG

%%

--Overall query 
Query           :: { S.Query }
                : '(' Query ')'                         { $2 }
                | select SType                        { S.Select $2 Nothing S.All }
                | select SType From                   { S.Select $2 (Just $3) S.All }
                | select distinct SType                { S.Select $3 Nothing S.Distinct }
                | select distinct SType From           { S.Select $3 (Just $4) S.Distinct }

SubQuery        :: { S.Query } 
                : '(' Query ')'                         { $2 }

-- Common Constructs
Alias           :: { S.Alias }                    -- Maybe String
                : identifier                    { Just $1 }
                | as identifier                 { Just $2 }

-- Primitives
Null            :: { S.PrimitiveType }                  
                : null                          { (S.Boolean S.Null) }

True            :: { S.PrimitiveType }                  
                : true                          { (S.Boolean S.TrueVal) }

False           :: { S.PrimitiveType }                   
                : false                         { (S.Boolean S.FalseVal) }

String          :: { S.PrimitiveType }        
                : string                        { (S.String $1) }

Number          :: { S.PrimitiveType }                           
                : integer                       { (S.Number $1) } -- for now we will keep numbers as a string
                | float                         { (S.Number $1) } -- for now we will keep numbers as a string

Primitive       :: { S.PrimitiveType }
                : Null                          { $1 }
                | True                          { $1 }
                | False                         { $1 }
                | String                        { $1 }
                | Number                        { $1 }


-- Expressions -- Things that evaluate to a value    
Expr            :: { S.Expr }
                : Primitive                     { S.Constant $1 }
                | identifier                    { S.Identifier $1 }
                | dotwalk                       { S.Identifier $1 }
                | identifier '(' Args ')'       { S.Function $1 $3 }
                | Operator                      { S.Operator $1 }
                | '(' Expr ')'                  { $2 }

Args            :: { S.Args }
                : Arg                           { [ $1 ] }
                | Args ',' Arg                  { ($3 : $1) }

Arg          :: { S.Arg } 
                : Expr                          { $1 }

Operator        :: { S.OperatorType }
                : Expr '+' Expr                 { S.Plus $1 $3 }
                | Expr '-' Expr                 { S.Minus $1 $3 }
                | Expr '*' Expr                 { S.Multiply $1 $3 }
                | Expr '/' Expr                 { S.FloatDivide $1 $3 }
                | Expr '%' Expr                 { S.Modulo $1 $3 }
                | Expr '=' Expr                 { S.Equals $1 $3 }
                | Expr '!=' Expr                { S.NotEquals $1 $3 }
                | Expr '<' Expr                 { S.LT $1 $3 }
                | Expr '<=' Expr                { S.LTE $1 $3 }
                | Expr '>' Expr                 { S.GT $1 $3 }
                | Expr '>=' Expr                { S.GTE $1 $3 }
                | Expr and Expr                 { S.And $1 $3 }
                | Expr or Expr                  { S.Or $1 $3 }
                | not Expr                      { S.Not $2 }
                | '-' Expr %prec NEG            { S.Neg $2 }

-- SELECT Clause
SType          :: { S.SelectType }
                : '*'                           { S.Wildcard }
                | Columns                       { S.Columns $1 }  

Columns         :: { [ S.Column ] }
                : Column                        { [$1] }      -- a list of a single Column
                | Columns ',' Column            { $3 : $1 }   -- a list of Columns

Column          :: { S.Column }
                : Expr                          { S.Column $1 Nothing}
                | Expr Alias                    { S.Column $1 $2 }


-- FROM Clause 
From            :: { S.FromClause }
                : from Tables Where GroupBy OrderBy Limit    { S.mkFromClause $2 $3 $4 $5 $6 }

Tables          :: { [ S.Table ] }
                : Table                         { [ $1 ] }
                | Tables ',' Table              { $3 : $1 }

Table           :: { S.Table }  
                : identifier                    { S.Table $1 Nothing }
                | identifier Alias              { S.Table $1 $2 }

Limit           :: { Maybe S.Limit }                  
                : {- empty -}                   { Nothing }
                | limit integer                 { Just $2 }

-- WHERE Clause 
Where           :: { Maybe S.Where }
                : {- empty -}                   { Nothing }
                | where WhereExpr               { Just $2 }

WhereExpr      :: { S.Expr }
                : Primitive                     { S.Constant $1 }
                | identifier                    { S.Identifier $1 }
                | dotwalk                       { S.Identifier $1 }
                | identifier '(' Args ')'       { S.Function $1 $3 }
                | WhereOperator                 { S.Operator $1 }
                | any SubQuery                  { S.SubQuery S.QAny $2 }
                | all SubQuery                  { S.SubQuery S.QAll $2 }
                | '(' WhereExpr ')'             { $2 }

WhereOperator   :: { S.OperatorType }
                : WhereExpr in '(' Query ')'         { S.In $1 ( S.Rows $4) }
                | WhereExpr in '(' Args ')'          { S.In $1 (S.Row $4) }
                | WhereExpr notIn '(' Query ')'      { S.NotIn $1 (S.Rows $4) }
                | WhereExpr notIn '(' Args ')'       { S.NotIn $1 (S.Row $4) }
                | WhereExpr '+' WhereExpr            { S.Plus $1 $3 }
                | WhereExpr '-' WhereExpr            { S.Minus $1 $3 }
                | WhereExpr '*' WhereExpr            { S.Multiply $1 $3 }
                | WhereExpr '/' WhereExpr            { S.FloatDivide $1 $3 }
                | WhereExpr '%' WhereExpr            { S.Modulo $1 $3 }
                | WhereExpr '=' WhereExpr            { S.Equals $1 $3 }
                | WhereExpr '!=' WhereExpr           { S.NotEquals $1 $3 }
                | WhereExpr '<' WhereExpr            { S.LT $1 $3 }
                | WhereExpr '<=' WhereExpr           { S.LTE $1 $3 }
                | WhereExpr '>' WhereExpr            { S.GT $1 $3 }
                | WhereExpr '>=' WhereExpr           { S.GTE $1 $3 }
                | WhereExpr and WhereExpr            { S.And $1 $3 }
                | WhereExpr or WhereExpr             { S.Or $1 $3 }
                | not WhereExpr                      { S.Not $2 }
                | '-' WhereExpr %prec NEG            { S.Neg $2 }

-- GROUP BY Clause 
GroupBy         :: { Maybe S.GroupBy }
                : {- empty -}                   { Nothing } 
                | groupBy ColNames              { Just $ S.GroupBy $2 Nothing }
                | groupBy ColNames Having       { Just $ S.GroupBy $2 (Just $3)}

ColNames        :: { [ String ] }
                : identifier                    { [ $1 ]}
                | dotwalk                       { [ $1 ] }
                | ColNames ',' identifier       { $3 : $1 }
                | ColNames ',' dotwalk          { $3 : $1 }

-- HAVING Clause 
Having          :: { S.Having }
                : having Expr                   { S.Having $2 }

-- ORDER BY Clause
OrderBy         :: { Maybe S.OrderBy }
                : {- empty -}                   { Nothing }
                | orderBy ColNames              { Just $ S.OrderBy $2 Nothing }
                | orderBy ColNames Direction    { Just $ S.OrderBy $2 (Just $3)}

Direction       :: { S.Direction } 
                : ascending                     { S.Ascending }
                | descending                    { S.Descending }

{
type Tok = T.Token

parseError :: [Tok] -> a
parseError tok = error $ "Parse error around " ++ (show tok)

}











