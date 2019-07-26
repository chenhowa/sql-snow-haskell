{
module Parser 
    ( parse

    ) where

import Parser.Syntax
import Parser.Syntax as S
import Lexer.Tokens as T

}

%name parse
%tokentype { T.Token }
%error { parseError }

%token
    select                      { T.Select }
    from                        { T.From }
    where                       { T.Where }
    groupBy                     { T.GroupBy }
    having                      { T.Having }
    in                          { T.In }
    distinct                    { T.Distinct }
    limit                       { T.Limit }
    orderBy                     { T.OrderBy }
    asc                         { T.Ascending }
    desc                        { T.Descending }
    union                       { T.Union }
    intersect                   { T.Intersect }
    all                         { T.All }
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
    identifier                  { T.Identifier ( Simple $$ ) }
    '('                         { T.RightParen }
    ')'                         { T.LeftParen }
    ','                         { T.Comma }
    lc                          { T.LineComment $$ }
    bc                          { T.BlockComment $$ }
    dotwalk                     { T.Identifier (Dotwalk $$) }
    integer                     { T.Constant (T.Integer $$) }
    float                       { T.Constant (T.Float $$) }
    string                      { T.Constant (T.String $$) }
    true                        { T.Constant (T.Boolean T.True) }
    false                       { T.Constant (T.Boolean T.False) }
    null                        { T.Constant (T.Boolean T.Null ) }




%%

-- Primitives
Null            :: { PrimitiveType }                  
                : null                          { (S.Boolean S.Null) }

True            :: { Primitive }                  
                : true                          { (S.Boolean S.True) }

False           :: { Primitive }                   
                : false                         { (S.Boolean S.Null) }

String          :: { Primitive }        
                : string                        { (S.String $1) }

Number          :: { Primitive }                           
                : integer                       { (S.Number $1) } -- for now we will keep numbers as a string
                | float                         { (S.Number $1) } -- for now we will keep numbers as a string

Primitive       :: { PrimitiveType }
                : Null                          { $1 }
                | True                          { $1 }
                | False                         { $1 }
                | String                        { $1 }
                | Number                        { $1 }


-- Expressions -- Things that evaluate to a value    
Expr            :: { Expr }
                : '(' Expr ')'                  { $1 }
                : Primitive                     { Constant $1 }
                | identifier '(' Args ')'       { Function $1 $3 }
                | BinaryOp                      { Operator (Binary $1) }
                | UnaryOp                       { Operator (Unary $1)}

Args            :: { Args }
                : Expr                          { [ $1 ] }
                | Args ',' Expr                 { ($2 : $1) }

BinaryOp        :: { BinaryOp }
                : Expr '+' Expr                 { Plus $1 $3 }
                | Expr '-' Expr                 { Minus $1 $3 }
                | Expr '*' Expr                 { Multiply $1 $3 }
                | Expr '/' Expr                 { FloatDivide $1 $3 }
                | Expr '%' Expr                 { Modulo $1 $3 }
                | Expr '=' Expr                 { Equals $1 $3 }
                | Expr '!=' Expr                { NotEquals $1 $3 }
                | Expr '<' Expr                 { S.LT $1 $3 }
                | Expr '<=' Expr                { S.LTE $1 $3 }
                | Expr '>' Expr                 { S.GT $1 $3 }
                | Expr '>=' Expr                { S.GTE $1 $3 }
                | Expr and Expr                 { And $1 $3 }
                | Expr or Expr                  { Or $1 $3 }

UnaryOp         :: { UnaryOp }
                : not Expr                      { Not $2 }
                : '-' Expr                      { Neg $2 }

-- SELECT Clause
Select          :: { Select }
                : select '*'                    { Select Wildcard }
                | select Columns                { Select (Columns $2) }  -- a list of Column

Columns         :: { [ Column ] }
                : Column                        { [$1] }      -- a list of a single Column
                | Columns ',' Column            { $2 : $1 }   -- a list of Columns

Column          :: { Column }
                : Name                          { Column $1 Nothing}
                | Name Alias                    { Column $1 $2 }
                | Expr Alias                    { Value $1 $2 }

Name            :: { String }
                : identifier                    { $1 }
                | dotwalk                       { $1 }

Alias           :: { Alias }                    -- Maybe String
                : identifier                    { Just $1 }
                | as identifier                 { Just $2 }


-- FROM Clause 
From            : from Tables                   { From $2 }

Tables          : Table                         { [$1] }
                | Tables ',' Table              { $2 : $1 }

Table           : identifier                    { Table $1 Nothing }
                | identifier Alias              { Table $1 $2 }















