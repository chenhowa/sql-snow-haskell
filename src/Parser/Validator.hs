module Parser.Validator where 

import qualified Parser.Syntax as S
import Control.Monad.State

data ValidState = ValidState 
    { valid :: Bool
    , errors :: String 
    , query :: S.Query
--    , input :: Input 
    , tables :: [ S.Table ]
    , columns :: [ S.Column ]
    }

initialValidState :: S.Query -> ValidState
initialValidState q = ValidState 
    { valid = True 
    , errors = ""
    , query = q 
    , tables = [] 
    , columns = []
    }

putTables :: State ValidState ()
putTables = do 
    state <- get 
    case query state of 
        S.Select _ from _ -> do
            put $ state { tables=(getTables from) }
        _ -> put $ state { tables=[], errors="not a select query" }
    return ()
    where 
        getTables :: (Maybe S.FromClause) -> [ S.Table ]
        getTables m = case m of 
            Nothing -> []
            Just from -> (S.tables from)
{-
validateQuery :: State ValidState Boolean 
validateQuery = do 
    putTables
    validateColumns

    state <- get
    case input state of 
        ValidSelect st maybeFrom -> do
            put $ { state input=(ValidColumns st) }
            validateColumns <- validateColumns
            case maybeFrom of 
                Nothing
        _ -> do 
            put $ state { error="invalid query"}

validateColumns :: State ValidState ()
validateColumns = do 
    state <- get
    case query state of
        S.Select _ stype _ _ -> do 
            case stype of 
                S.Wildcard -> validateWildcard
                S.Columns cols -> do 
                    if tablesMatchColumns (tables state) cols
                    then do 
                        putColumns
                    else 
                        putError
        _ -> putError
    return () 

validateWildcard :: State ValidState ()
validateWildcard = do 
    state <- get
    if (length $ tables state) > 0 of 
    then do 
        return ()
    else do 
        putError

putColumns :: State ValidState () 
putColumns = do 
    state <- get
    put $ state { columns = (getColumns (query state)) }

data Input
    = ValidSelect S.SelectType (Maybe S.FromClause)
    | ValidFrom S.SelectType 
    | ValidColumns S.SelectType
    | ValidColumn 
    | ValidExpr S.Expr 
    | ValidFunction S.ID S.Args


validateColumns :: State ValidState Boolean
validateColumns = do
    state <- get
    case input state of 
        ValidColumns st -> do 
            case st of 
                Columns cols -> do
                    b <- validateCol
                _ -> do 
                    return True
        _ -> do 
            errorValidation

validateCol :: State ValidState Boolean
validateCol = do 
    state <- get 
    case input state of
        ValidColumn expr alias -> do 
            put $ state { input = (ValidExpr expr) }
            valid <- validateExpr 
        _ -> do 
            errorValidation

validateExpr :: State ValidState Boolean
validateExpr = do 
    state <- get
    case input state of
        ValidExpr expr -> do 
            b <- validateSelectExpr
        _ -> do 
            errorValidation


validateFunction :: State ValidState Boolean 
validateFunction = do 
    state <- get 
    case input state of 
        ValidFunction id args -> do

        _ -> do 
            errorValidation

putError :: State ValidState ()
putError = do 
    state <- get 
    put $ state { error = "invalid query" }
    return ()

-}


    

