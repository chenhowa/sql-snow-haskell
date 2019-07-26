module Parser.Syntax where 


type Syntax = Int

data Select
    = Select Columns

data Columns 
    = Wildcard
    | Columns [ Column ]

data Column 
    = Column Expr Alias

type Alias = Maybe String

-- An Expr is something that can be evaluated down to a concrete value
data Expr 
    = Identifier ID
    | Constant String 
    | Function Fn [ Args ]

type ID = String
type Op1 = Expr
type Op2 = Expr

data Fn 
    = Named ID [ Expr ]
    | Plus Op1 Op2 
    | Minus Op1 Op2 
    | FloatDivide Op1 Op2 
    | Multiply Op1 Op2
    | Modulo Op1 Op2 
    | Equals Op1 Op2
    | NotEquals Op1 Op2 
    | LT Op1 Op2 
    | LTE Op1 Op2 
    | GT Op1 Op2 
    | GTE Op1 Op2
    | And Op1 Op2 
    | Or Op1 Op2 
    | Not Op1

type Args = [ Arg ]

data Arg 
    = Arg Expr