module Parser.Syntax where 

data Query 
    = Select SelectType (Maybe FromClause) Unique
    | Union Unique Query Query
    | Intersect Unique Query Query
    deriving (Eq, Show)

{- PRIMITIVES -}
data Primitive 
    = Primitive PrimitiveType
    deriving (Eq, Show)


data PrimitiveType
    = Boolean BooleanType
    | Number String -- Is this right? I don't suppose SQL really distinguishes between ints and floats
    | String String
    deriving (Eq, Show)


data BooleanType
    = TrueVal
    | FalseVal
    | Null
    deriving (Eq, Show)


{- SELECT Clause -}

data SelectType 
    = Wildcard
    | Columns [ Column ]
    deriving (Eq, Show)


data Column 
    = Column Expr Alias
    deriving (Eq, Show)

data Unique
    = All 
    | Distinct
    deriving (Eq, Show)

type Alias = Maybe String

{- EXPRESSIONS -}
-- An Expr is something that can be evaluated down to a concrete value
data Expr 
    = Identifier ID
    | Constant PrimitiveType 
    | Function ID Args
    | Operator OperatorType
    | SubQuery Modifier Query
    | Row [Op]
    | Rows Query
    deriving (Eq, Show)

data Modifier 
    = QAll 
    | QAny
    | Exists
    deriving (Eq, Show)

type Args = [ Arg ]
type Arg = Expr
type ID = String

data OperatorType
    = Plus Op Op 
    | Minus Op Op 
    | FloatDivide Op Op 
    | Multiply Op Op
    | Modulo Op Op 
    | Equals Op Op
    | NotEquals Op Op 
    | LT Op Op 
    | LTE Op Op 
    | GT Op Op
    | GTE Op Op
    | And Op Op
    | Or Op Op
    | Not Op
    | Neg Op
    | In Op Op
    | NotIn Op Op
    deriving (Eq, Show)
type Op = Expr

data FromClause = FromClause 
    { tables :: [ Table ]
    , where_ :: Maybe Where
    , groupBy :: Maybe GroupBy
    , orderBy :: Maybe OrderBy
    , limit :: Maybe Limit
    }
    deriving (Eq, Show)

mkFromClause :: [Table] -> Maybe Where -> Maybe GroupBy -> Maybe OrderBy -> Maybe Limit -> FromClause
mkFromClause ts w g o l = FromClause
    { tables = ts 
    , where_ = w 
    , groupBy = g 
    , orderBy = o 
    , limit = l
    }

data Table 
    = Table String Alias
    | Join JoinType Table Table OnColumns
    | Natural Table Table
    deriving (Eq, Show)

data JoinType 
    = Inner
    | LeftOuter
    | RightOuter
    | FullOuter
    deriving (Eq, Show)

type OnColumns = (ID, ID)

type Limit = String

{- WHERE Clause -}

type Where = Expr

{- GROUP BY Clause -}
data GroupBy
    = GroupBy [ ID ] (Maybe Having)
    deriving (Eq, Show)

{- HAVING Clause -}
data Having
    = Having Expr
    deriving (Eq, Show)

{- ORDER BY -}
data OrderBy 
    = OrderBy [String] (Maybe Direction)
    deriving (Eq, Show)

data Direction 
    = Ascending 
    | Descending
    deriving (Eq, Show)
