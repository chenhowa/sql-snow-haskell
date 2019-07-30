module Parser.Validator.Expression where 

import qualified Parser.Syntax as S
import Control.Monad.State
import qualified Data.Map.Strict as Map

data ValidExprState = ValidExprState 
    { errors :: String
    , expr :: S.Expr
    }
    deriving (Eq, Show)

data Type
    = Boolean 
    | Number
    | String
    | Subquery
    | Identifier


validateExprTypes :: State ValidExprState Type 
validateExprTypes = do 
    state <- get
    case expr state of
        S.Identifier id -> Identifier
        S.Constant prim -> case prim of 
            S.Boolean _ -> Boolean
            S.Number _ -> Number 
            S.String _ -> String
        S.SubQuery _ _ -> SubQuery
        S.Operator opType -> runState validateOperatorTypes
        S.Function id args -> runState validateFunction

data ValidOpState = ValidOpState 
    { errors :: String
    , op :: S.OperatorType
    }

validateOperatorTypes :: Type -> State ValidOpState Type
validateOperatorTypes expected = do 
    state <- get 
    case op state of 
        Plus op1 op2 -> 
            let type1 = runState validateExprTypes
                type2 = runState validateExprTypes

        Minus Op Op 
        FloatDivide Op Op 
        Multiply Op Op
        Modulo Op Op 
        Equals Op Op
        NotEquals Op Op 
        LT Op Op 
        LTE Op Op 
        GT Op Op
        GTE Op Op
        And Op Op
        Or Op Op
        Not Op
        Neg Op
        In Op Values
        NotIn Op Values

        