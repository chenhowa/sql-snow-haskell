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
    identifier                  { T.Identifier $$ }
    constant                    { T.Constant $$ }
    '('                         { T.RightParen }
    ')'                         { T.LeftParen }
    ','                         { T.Comma }
    lc                          { T.LineComment $$ }
    bc                          { T.BlockComment $$ }


%%

Query           : Select                        { QuerySelect $1 }

Select          :: { Select }
                : select '*'                    { Select Wildcard }
                | select Columns                { Select (Columns $2) }

Columns         :: { Columns }
                : Column                        { [$1] }
                | Columns ',' Column            { $2 : $1 }

Column          :: { Column }
                : identifier                    { Column (Identifier $1) Nothing}
                | identifier Alias              { Column (Identifier $1) $2 }
                | Expr Alias                    { Column (Expr $1) $2 }

Alias           :: { Alias }
                : identifier                    { Just $1 }
                | as identifier                 { Just $2 }

Expr            :: { Expr }
                : Function                      { Expr $1 }
                | constant                      { Expr (Constant $1) }
                | BinaryOp                      { Expr $1 }
                
Function        :: { Fn }
                : identifier '(' Args ')'       { Function (Identifier $1) $3 }

Args            :: { Args }
                : Arg                           { Arg [$1] }
                | Args ',' Arg                  { $2:$1 }

Arg             :: { Arg }
                : identifier                    { Identifier $1 }
                | Expr                          { $1 }

BinaryOp        :: { Fn }
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

UnaryOp         :: { Fn }
                : not Expr                      { Not $2 }


From            : from Tables                   { From $2 }

Tables          : Table                         { [$1] }
                | Tables ',' Table              { $2 : $1 }

Table           : identifier                    { Table $1 Nothing }
                | identifier Alias              { Table $1 $2 }















