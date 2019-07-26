{
module Parser 
    ( parse

    ) where

import Parser.Syntax
import Parser.Syntax as S
import Lexer.Tokens

}

%name parse
%tokentype { Token }
%error { parseError }

%token
    select                      { TokenSelect }
    from                        { TokenFrom }
    where                       { TokenWhere }
    groupBy                     { TokenGroupBy }
    having                      { TokenHaving }
    in                          { TokenIn }
    distinct                    { TokenDistinct }
    limit                       { TokenLimit }
    orderBy                     { TokenOrderBy }
    asc                         { TokenAscending }
    desc                        { TokenDescending }
    union                       { TokenUnion }
    intersect                   { TokenIntersect }
    all                         { TokenAll }
    left                        { TokenLeft }
    right                       { TokenRight }
    inner                       { TokenInner }
    outer                       { TokenOuter }
    natural                     { TokenNatural }
    join                        { TokenJoin }
    on                          { TokenOn }
    '+'                         { TokenPlus }
    '-'                         { TokenMinus }
    '*'                         { TokenAsterisk }
    '/'                         { TokenFloatDivide }
    '%'                         { TokenModulo }
    '='                         { TokenEquals }
    '!='                        { TokenNotEquals }
    '<'                         { TokenLT }
    '<='                        { TokenLTE }
    '>'                         { TokenGT }
    '>='                        { TokenGTE }
    not                         { TokenNot }
    and                         { TokenAnd }
    or                          { TokenOr }
    as                          { TokenAs }
    identifier                  { TokenIdentifier $$ }
    constant                    { TokenConstant $$ }
    '('                         { TokenRightParen }
    ')'                         { TokenLeftParen }
    ','                         { TokenComma }
    lc                          { TokenLineComment $$ }
    bc                          { TokenBlockComment $$ }


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















