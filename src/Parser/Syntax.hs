module Parser.Syntax where 

{- PRIMITIVES -}
data Primitive 
    = Primitive PrimitiveType

data PrimitiveType
    = Boolean BooleanType
    | Number String -- Is this right? I don't suppose SQL really distinguishes between ints and floats
    | String String

data BooleanType
    = TrueVal
    | FalseVal
    | Null

{- SELECT Clause -}
data Select
    = Select SelectType

data SelectType 
    = Wildcard
    | Columns [ Column ]

data Column 
    = Column String Alias
    | Value Expr Alias

type Alias = Maybe String

{- EXPRESSIONS -}
-- An Expr is something that can be evaluated down to a concrete value
data Expr 
    = Identifier ID
    | Constant PrimitiveType 
    | Function ID Args
    | Operator OperatorType

type Args = [ Expr ]
type ID = String

data OperatorType
    = Binary BinaryOp
    | Unary UnaryOp

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

data UnaryOp
    = Not Op
    | Neg Op

type Op = Expr

{- FROM Clause -}
data From  
    = From [ Table ]

data Table 
    = Table String Alias