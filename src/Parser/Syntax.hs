module Parser.Syntax where 

data Query 
    = Select SelectType
    | From [ Table ]
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

data Table 
    = Table String Alias
    deriving (Eq, Show)
