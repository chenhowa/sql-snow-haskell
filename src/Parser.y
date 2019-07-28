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
    distinct                    { T.Distinct }
    limit                       { T.Limit }
    orderBy                     { T.OrderBy }
    ascending                   { T.Ascending }
    descending                  { T.Descending }
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
    '('                         { T.LeftParen }
    ')'                         { T.RightParen }
    ','                         { T.Comma }
    bc                          { T.BlockComment $$ }
    dotwalk                     { T.Dotwalk $$ }
    integer                     { T.Constant (T.Integer $$) }
    float                       { T.Constant (T.Float $$) }
    string                      { T.Constant (T.String $$) }
    true                        { T.Constant (T.Boolean T.TrueVal) }
    false                       { T.Constant (T.Boolean T.FalseVal) }
    null                        { T.Constant (T.Boolean T.Null ) }

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
                : Select                        { S.Select $1 Nothing  }
                | Select From                   { S.Select $1 (Just $2) }

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
Select          :: { S.SelectType }
                : select '*'                    { S.Wildcard }
                | select Columns                { S.Columns $2 }  -- a list of Column

Columns         :: { [ S.Column ] }
                : Column                        { [$1] }      -- a list of a single Column
                | Columns ',' Column            { $3 : $1 }   -- a list of Columns

Column          :: { S.Column }
                : Expr                          { S.Column $1 Nothing}
                | Expr Alias                    { S.Column $1 $2 }


-- FROM Clause 
From            :: { S.From }
                : from Tables                   { S.From $2 Nothing Nothing Nothing Nothing}
                | from Tables GroupBy           { S.From $2 Nothing (Just $3) Nothing Nothing}
                | from Tables Where             { S.From $2 (Just $3) Nothing Nothing Nothing}
                | from Tables Where GroupBy     { S.From $2 (Just $3) (Just $4) Nothing  Nothing}
                | from Tables OrderBy                   { S.From $2 Nothing Nothing (Just $3)  Nothing}
                | from Tables GroupBy OrderBy           { S.From $2 Nothing (Just $3) (Just $4)  Nothing}
                | from Tables Where OrderBy             { S.From $2 (Just $3) Nothing (Just $4)  Nothing} 
                | from Tables Where GroupBy OrderBy     { S.From $2 (Just $3) (Just $4) (Just $5) Nothing}
                | from Tables Limit                  { S.From $2 Nothing Nothing Nothing (Just $3) }
                | from Tables GroupBy Limit          { S.From $2 Nothing (Just $3) Nothing (Just $4)}
                | from Tables Where Limit            { S.From $2 (Just $3) Nothing Nothing (Just $4)}
                | from Tables Where GroupBy Limit    { S.From $2 (Just $3) (Just $4) Nothing (Just $5)}
                | from Tables OrderBy Limit                  { S.From $2 Nothing Nothing (Just $3) (Just $4)}
                | from Tables GroupBy OrderBy Limit          { S.From $2 Nothing (Just $3) (Just $4) (Just $5)}
                | from Tables Where OrderBy Limit            { S.From $2 (Just $3) Nothing (Just $4) (Just $5)} 
                | from Tables Where GroupBy OrderBy Limit    { S.From $2 (Just $3) (Just $4) (Just $5) (Just $6)}

Tables          :: { [ S.Table ] }
                : Table                         { [ $1 ] }
                | Tables ',' Table              { $3 : $1 }

Table           :: { S.Table }
                : identifier                    { S.Table $1 Nothing }
                | identifier Alias              { S.Table $1 $2 }

Limit           :: { S.Limit }                  
                : limit integer                 { S.Limit $2 }

-- WHERE Clause 
Where           :: { S.Where }
                : where Expr                    { S.Where $2 }

-- GROUP BY Clause 
GroupBy         :: { S.GroupBy }
                : groupBy ColNames              { S.GroupBy $2 Nothing }
                | groupBy ColNames Having       { S.GroupBy $2 (Just $3)}

ColNames        :: { [ String ] }
                : identifier                    { [ $1 ]}
                | dotwalk                       { [ $1 ] }
                | ColNames ',' identifier       { $3 : $1 }
                | ColNames ',' dotwalk          { $3 : $1 }

-- HAVING Clause 
Having          :: { S.Having }
                : having Expr                   { S.Having $2 }

-- ORDER BY Clause
OrderBy         :: { S.OrderBy }
                : orderBy ColNames              { S.OrderBy $2 Nothing }
                | orderBy ColNames Direction    { S.OrderBy $2 (Just $3)}

Direction       :: { S.Direction } 
                : ascending                     { S.Ascending }
                | descending                    { S.Descending }

{
type Tok = T.Token

parseError :: [Tok] -> a
parseError tok = error $ "Parse error around " ++ (show tok)

}











