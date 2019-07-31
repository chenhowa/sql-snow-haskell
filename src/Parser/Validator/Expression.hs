module Parser.Validator.Expression where 

import qualified Parser.Syntax as S
import Control.Monad.State
import qualified Data.Map.Strict as Map

data ValidExprState = ValidExprState 
    { exprErrors :: String
    , expr :: S.Expr
    }
    deriving (Eq, Show)

data Type
    = Boolean 
    | Number
    | String
    | Subquery
    | Identifier
    | Unknown
    deriving (Ord, Eq, Show)

validateExprTypes :: State ValidExprState Type 
validateExprTypes = do 
    state <- get
    return ( case expr state of
        S.Identifier id -> Identifier
        S.Constant prim -> case prim of 
            S.Boolean _ -> Boolean
            S.Number _ -> Number 
            S.String _ -> String
        S.SubQuery _ _ -> Subquery
        S.Operator opType -> Number -- Fix 
        S.Function id args -> Number -- Fix
                )

data ValidOpState = ValidOpState 
    { opErrors :: String
    , op :: S.OperatorType
    }
    deriving (Eq, Show)

validateOpTypes :: State ValidOpState Type
validateOpTypes = do 
    state <- get
    let operator = op state
        args = operatorArgs operator
        info = operatorInfo operator
        typeCheckers = argTypes info
    t <- return
            (  
                if (length typeCheckers == length args) && 
                       (foldr (&&) True ( typeCheckers <*> (findType <$> args))) 
                then (returnType info)
                else Unknown        
            )
    return t

    where findType :: S.Expr -> Type
          findType ex = evalState validateExprTypes (ValidExprState {exprErrors="", expr=ex })

data OperatorInfo  
    = OperatorInfo
        { returnType :: Type
        , argTypes :: [ Type -> Bool]
        }
    | SpecialInfo { r :: Type }

mkOperatorInfo :: Type -> [Type -> Bool] -> OperatorInfo 
mkOperatorInfo ret args = OperatorInfo 
            { returnType = ret
            , argTypes = args
            }

operatorInfo :: S.OperatorType -> OperatorInfo
operatorInfo op = case op of 
    S.Plus _ _ ->  mkOperatorInfo Number [ (==) Number,  (==) Number]
    S.Minus _ _ ->  mkOperatorInfo Number [ (==) Number,  (==) Number]
    S.FloatDivide _ _ ->  mkOperatorInfo Number [ (==) Number,  (==) Number]
    S.Multiply _ _ ->  mkOperatorInfo Number [ (==) Number,  (==) Number]
    S.Modulo _ _ ->  mkOperatorInfo Number [ (==) Number,  (==) Number]
    S.Equals _ _ ->  mkOperatorInfo Boolean [ (==) Number,  (==) Number]
    S.NotEquals _ _ ->  mkOperatorInfo Boolean [ (==) Number,  (==) Number]
    S.LT _ _ ->  mkOperatorInfo Boolean [ (==) Number,  (==) Number]
    S.LTE _ _ ->  mkOperatorInfo Boolean [ (==) Number,  (==) Number]
    S.GT _ _ ->  mkOperatorInfo Boolean [ (==) Number,  (==) Number]
    S.GTE _ _ ->  mkOperatorInfo Boolean [ (==) Number,  (==) Number]
    S.And _ _ ->  mkOperatorInfo Boolean [ (==) Boolean,  (==) Boolean]
    S.Or _ _ ->  mkOperatorInfo Boolean [ (==) Boolean,  (==) Boolean]
    S.Not _ ->  mkOperatorInfo Boolean [ (==) Boolean ]
    S.Neg _ ->  mkOperatorInfo Number [(==) Number]
    S.In _ _ ->  mkOperatorInfo Number [(==) Number, (==) Subquery]
    S.NotIn _ _ ->  mkOperatorInfo Number [(==) Number, (==) Subquery]

operatorArgs :: S.OperatorType -> S.Args 
operatorArgs op = case op of 
    S.Plus op1 op2 ->  [op1, op2]
    S.Minus op1 op2 ->  [op1, op2]
    S.FloatDivide op1 op2 ->  [op1, op2]
    S.Multiply op1 op2 ->  [op1, op2]
    S.Modulo op1 op2 ->  [op1, op2]
    S.Equals op1 op2 ->  [op1, op2]
    S.NotEquals op1 op2 ->  [op1, op2]
    S.LT op1 op2 ->  [op1, op2]
    S.LTE op1 op2 ->  [op1, op2]
    S.GT op1 op2 ->  [op1, op2]
    S.GTE op1 op2 ->  [op1, op2]
    S.And op1 op2 ->  [op1, op2]
    S.Or op1 op2 ->  [op1, op2]
    S.Not op1 ->  [op1]
    S.Neg op1 ->  [op1]
    S.In op1 _ ->  [op1]
    S.NotIn op1 _ ->  [op1]