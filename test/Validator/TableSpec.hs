module Validator.TableSpec where 

import Test.Hspec

import Validator.Table
import qualified Parser.Syntax as P

spec :: Spec
spec = do
    describe "errors across tables" $ do 
        describe "non-join" $ do 
            it "same table twice, first has no alias" $ do 
                let q = P.Select P.Wildcard from P.All
                    from = Just $ P.FromClause 
                            { P.tables = tables 
                            , P.where_ = Nothing
                            , P.groupBy = Nothing 
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                    tables = [P.Table "incident" Nothing, P.Table "incident" $ Just "I"]
                in  validateTables tables `shouldSatisfy` isJust
            it "different tables, same aliases" $ do 
                let tables = [P.Table "incident" $ Just "I", P.Table "problem" $ Just "I"]
                in  validateTables tables `shouldSatisfy` isJust
        describe "join" $ do 
            it "same table twice, first has no alias" $ do 
                let tables = 
                    [ P.Join P.Inner 
                        (P.Join P.Inner 
                            (P.Table "incident" Nothing)
                            (P.Table "change" Nothing)
                            ("sys_id", "sys_id")
                        )
                        (P.Table "incident" $ Just "I")
                        ("sys_id", "sys_id")
                    ]
                in  validateTables tables `shouldSatisfy` isJust
            it "different tables, same aliases" $ do 
                let tables =
                    [ P.Join P.Inner
                        (P.Join P.Inner
                            (P.Table "incident" $ Just "I")
                            (P.Table "incident" $ Just "In")
                            ("sys_id", "sys_id")
                        )
                        (P.Table "change" $ Just "I")
                        ("sys_id", "sys_id")
                    ]
                in validateTables tables `shouldSatisfy` isJust
        describe "join and non-join" $ do 
            it "same table twice, first has no alias" $ do 
                let tables = 
                    [ P.Join P.Inner
                        (P.Table "incident" Nothing)
                        (P.Table "change" $ Just "C")
                        ("sys_id", "sys_id")
                    , P.Table "incident" $ Just "I"
                    ]
                in  validateTables tables `shouldSatisfy` isJust
            it "different tables, same aliases" $ do 
                let tables = 
                    [ P.Join P.Inner
                        (P.Table "incident" Nothing)
                        (P.Table "change" $ Just "C")
                        ("sys_id", "sys_id")
                    , P.Table "incident" $ Just "C"
                    ]
                in  validateTables tables `shouldSatisfy` isJust
    describe $ "expected success across tables" $ do 
        it "same table twice, with different aliases" $ do 
            let tables = 
                [ P.Table "incident" $ Just "I", P.Table "incident" $ Just "In"]
            in  validateTables tables `shouldSatisfy` isNothing
        it "same table in join twice, with different aliases" $ do 
            let tables = 
                [ P.Join P.Inner 
                    (P.Join P.Inner 
                        (P.Table "incident" $ Just "In")
                        (P.Table "change" Nothing)
                        ("sys_id", "sys_id")
                    )
                    (P.Table "incident" $ Just "I")
                    ("sys_id", "sys_id")
                ]
            in  validateTables tables `shouldSatisfy` isNothing