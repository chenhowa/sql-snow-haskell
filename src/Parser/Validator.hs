module Parser.Validator where 

import qualified Parser.Syntax as S
import Control.Monad.State
import qualified Data.Map.Strict as Map

data ValidState = ValidState 
    { valid :: Bool
    , errors :: String 
    , query :: S.Query
--    , input :: Input 
    , tables :: [ S.Table ]
    , columns :: Maybe S.SelectType
    }

initialValidState :: S.Query -> ValidState
initialValidState q = ValidState 
    { valid = True 
    , errors = ""
    , query = q 
    , tables = [] 
    , columns = Nothing
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

putColumns :: State ValidState () 
putColumns = do 
    state <- get
    case query state of 
        S.Select stype _ _ -> do
            put $ state { columns = ( maybeColumns stype) }
        _ -> put $ state { columns=Nothing, errors="not a select query" }
    return ()
    where 
        maybeColumns :: S.SelectType -> Maybe S.SelectType
        maybeColumns s = Just s



{-
validateQuery :: State ValidState ()
validateQuery = do 
    validateColumns
    validateTables
    validateExpressions
    validateColumnsMatchTables
    validateSubQueries

    state <- get
    case input state of 
        ValidSelect st maybeFrom -> do
            put $ { state input=(ValidColumns st) }
            validateColumns <- validateColumns
            case maybeFrom of 
                Nothing
        _ -> do 
            put $ state { errors="invalid query"}

validateColumnsMatchTables :: State ValidState ()
validateColumnsMatchTables = do 
    putTables
    putColumns
    state <- get
    if columnsMatchTables (columns state) (tables state)
    then do putError
    else do putError
    return ()
    where 
        columnsMatchTables :: S.SelectType -> [ S.Table ] -> Boolean
        columnsMatchTables stype tables = 
            case stype of 
                S.Wildcard -> not $ null tables
                S.Columns cols -> 
                    let tableMap = buildTableNameMap tables
                    in  foldr (columnInMap tableMap) True cols
        buildTableNameMap :: [ S.Table ] -> Map.Map String (Maybe String)
        buildTableNameMap tables = 
            Map.fromList (convertToTuples tables)
            where 
                convertToTuples :: [S.Table] -> [(String, Maybe String)]
                convertToTuples tables = concat (convert <$> tables)
                    where
                        convert :: S.Table -> [(String, Maybe String)]
                        convert table = case table of 
                            S.Table id alias -> 
                                let idTup = [(id, alias)]
                                    aliasTup = case alias of 
                                        Nothing -> []
                                        Just a -> [(a, Just id)]
                                in  idTup <> aliasTup
        columnInMap :: Map.Map String (MaybeString) -> S.Column -> Bool -> Bool
        columnInMap map (S.Column expr alias) b = 
            let tables = tablesInExpr col []
            in  b `and` (toBool $ Map.lookup map tables)
        
        tablesInExpr :: S.Expr -> [(Table, Column)] -> [(Table, Column)]
        tablesInExpr expr acc = case expr of 
            S.Identifier str -> [(str, str)] <> acc
            S.Constant _ -> acc
            S.Function _ args -> ( concat ( (flip tablesInExpr) acc  <$> args) )
            S.Operator opType ->  acc <> (applyTablesInExprs $ S.operatorArgs opType)
            S.SubQuery _ _ -> acc
            where 
                applyTablesInExprs :: [Expr] -> [(Table, Column)]
                applyTablesInExprs exprs = concat ((tablesInExpr []) <$> exprs)
        toBool :: Maybe a -> Bool 
        toBool maybe = case maybe of 
            Just _ -> True
            Nothing -> False
                        
type Table = String
type Column = String
-}

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


    

