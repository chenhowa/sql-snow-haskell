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
    = Column String Alias
    | Value Expr Alias
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


type Args = [ Expr ]
type ID = String

data OperatorType
    = Binary BinaryOp
    | Unary UnaryOp
    deriving (Eq, Show)


data BinaryOp
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
    deriving (Eq, Show)


data UnaryOp
    = Not Op
    | Neg Op
    deriving (Eq, Show)


type Op = Expr

{- FROM Clause -}

data Table 
    = Table String Alias
    deriving (Eq, Show)
