module Parser.Syntax where 

data Query 
    = Select SelectType (Maybe From)
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


type Alias = Maybe String

{- EXPRESSIONS -}
-- An Expr is something that can be evaluated down to a concrete value
data Expr 
    = Identifier ID
    | Constant PrimitiveType 
    | Function ID Args
    | Operator OperatorType
    deriving (Eq, Show)

{-data Arg
    = Col ID
    | Val Expr
    deriving (Eq, Show)-}

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
    deriving (Eq, Show)


type Op = Expr

{- FROM Clause -}

data From
    = From [ Table ] (Maybe Where) (Maybe GroupBy) (Maybe OrderBy) (Maybe Limit)
    deriving (Eq, Show)

data Table 
    = Table String Alias
    deriving (Eq, Show)

data Limit
    = Limit String
    deriving (Eq, Show)

{- WHERE Clause -}

data Where 
    = Where Expr
    deriving (Eq, Show)

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
