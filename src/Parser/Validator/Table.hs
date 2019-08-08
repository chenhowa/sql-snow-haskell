module Parser.Validator.Table where 

import qualified Parser.Syntax as P
import Control.Monad.State
import qualified Data.Map.Strict as Map

type Tables = [ P.Table ]

{- This module seeks to validate the tables within the query. The following validations are desired:
    1. Across multiple tables, the same alias is not used twice
    2. If a single table occurs twice, it must be aliased (otherwise we have ambiguity)
    3. Within a nested joins table, the tables used in an ON clause must have been already earlier in the nested joins table
    4. Within a nested joins table, the same alias is not used twice.
-}

validateTables :: Tables -> Maybe Error
validateTables tables = undefined

validateTable :: P.Table -> Maybe Error
validateTable = undefined

type TableName = String
type Alias = String
type Error = String

data AcrossTableState = 
    State 
        { aliasSoFar :: Map.Map Alias [TableName]
        , tablesSoFar :: Map.Map TableName Bool
        , errors :: [Error]
        }

data AcrossJoinState = 
    JoinState 
        { joinTablesSoFar :: Map.Map TableName Bool
        , joinAliasSoFar :: Map.Map Alias [TableName]

        }

validateAcrossTables :: AcrossTableState -> [P.Table] -> AcrossTableState
validateAcrossTables ats tables = 
    foldr validateTable ats tables 
    where 
        validateTable :: P.Table -> AcrossTableState -> AcrossTableState
        validateTable table state@(State {aliasSoFar = asf, tablesSoFar = tsf, errors = es}) = case table of 
            P.Table id malias ->
                let (ntsf, nasf, nes) = case Map.lookup id tsf of
                        Nothing -> (Map.insert id True tsf, asf, es) -- if table is seen for first time, no big deal
                        Just _ -> case malias of  -- if table is seen for second time, check if it has alias
                            Nothing -> (tsf, asf, ("table \'" <> id <> "\' has been used more than once, and must be aliased" : es )) -- if it has no alias, we have a problem
                            Just alias -> case Map.lookup alias asf of 
                                Nothing -> (tsf, Map.insert alias [id] asf, es) -- if the alias has never been used before, great.
                                Just tables -> (tsf, Map.insert alias (id:tables) asf, ("Alias" <> alias <> " has been used for multiple tables" :es)) -- if the alias has been used before, we have a problem
                in  State 
                        { aliasSoFar = nasf
                        , tablesSoFar = ntsf
                        , errors = nes
                        }
            P.Join _ t1 t2 _ -> 
                let emptyJS = JoinState {joinTablesSoFar = Map.empty, joinAliasSoFar = Map.empty}
                in  snd (validateJoin t2 $ validateJoin t1 emptyJS)
        validateJoin :: P.Table -> (AcrossJoinState, AcrossTableState) -> (AcrossJoinState, AcrossTableState)
        validateJoin table 
                (
                    jstate@(JoinState { joinTablesSoFar = jtsf, joinAliasSoFar = jasf})
                    tstate@(State {aliasSoFar = asf, tablesSoFar = tsf, errors = es})
                ) = 
                    let x = case table of 
                        P.Table id malias ->
                            case Map.lookup id tsf of 
                                Just _ -> case malias of  -- table was seen before
                                    Nothing -> "Table \'" <> id <> "\' is used ambiguously. It should have an alias" : es
                                    Just alias -> case Map.lookup alias asf of 
                                        Nothing -> -- CHECK THE JOIN ISSUES NOW
                                        Just before -> (jstate, tstate {aliasSoFar = Map.insert alias (id : before)})
                                Nothing -> -- table was not seen before, so check whetehr the alias was used correctly ... an so on
                            {-First we check whether this table was seen before, and if it was, whether it was aliased-}
                        P.Join _ t1 t2 _ -> validateJoin t2 $ validateJoin t1 (jstate, tstate)