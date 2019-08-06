module Optimizer.TableInfoSpec where 

import Test.Hspec

import Optimizer.TableInfo
import qualified Parser.Syntax as P

spec :: Spec
spec = do
    describe "failure" $ do 
        it "does not generate on non-select queries" $ do
            let q = P.Union P.All selectWildcard selectWildcard
                selectWildcard = P.Select P.Wildcard Nothing P.All
            extractQueryInfo q `shouldBe` []
    describe "success" $ do 
        it "extracts the used tables from a FROM clause" $ do 
            let q = P.Select P.Wildcard (Just from) P.All
                from = P.FromClause
                        { P.tables = 
                            [ P.Table "incident" Nothing
                            , P.Join P.Inner (P.Table "problem" $ Just "P") (P.Table "sc_task" $ Just "S") ("sys_id", "sys_id")
                            ]
                        , P.where_ = Nothing
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing
                        , P.limit = Nothing
                        }
                tables = tableInfo <$> (extractQueryInfo q)
            tables `shouldBe` [("incident", "incident"), ("problem", "P"), ("sc_task", "S")]
        describe "extracts the used columns from a WHERE clause" $ do 
            it "when there is only one table" $ do 
                let q = P.Select P.Wildcard (Just from) P.All
                    from = P.FromClause 
                        { P.tables = [ P.Table "incident" Nothing ]
                        , P.where_ = Just $ P.Operator $ P.Plus (P.Identifier "number") (P.Identifier "category")
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing 
                        , P.limit = Nothing
                        }
                    columns = projection <$> (extractQueryInfo q)
                columns `shouldBe` [["number", "category"]]
            it "when there are multiple tables" $ do 
                let q = P.Select P.Wildcard (Just from) P.All
                    from = P.FromClause 
                        { P.tables = [ P.Table "incident" $ Just "i", P.Table "problem" $ Just "p" ]
                        , P.where_ = Just $ P.Operator $ P.Plus (P.Identifier "incident.number") (P.Identifier "p.category")
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing 
                        , P.limit = Nothing
                        }
                    columns = projection <$> (extractQueryInfo q)
                columns `shouldBe` [ ["number"]
                                   , ["category"]
                                   ]
        describe "extracts the used columns from a group-by clause" $ do 
            it "extractColumnsFromGroupBy" $ do 
                let gb = Just $ P.GroupBy [ "incident.number", "category" ] Nothing
                    colInfo = extractColumnsFromGroupBy gb
                getProjection colInfo ("incident", "incident") `shouldBe` ["number", "category"]
            describe "one table" $ do 
                it "without having" $ do 
                    let q = P.Select P.Wildcard (Just from) P.All
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "category" ] Nothing
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        columns = projection <$> (extractQueryInfo q)
                    columns `shouldBe` [["number", "category"]]
                it "with having" $ do 
                    let q = P.Select P.Wildcard (Just from) P.All
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "category" ] having
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        having = Just $ P.Having $ P.Operator $ P.Plus (P.Identifier "incident.description") (P.Identifier "state")
                        columns = projection <$> (extractQueryInfo q)
                    columns `shouldBe` [["number", "description", "category", "state"]]
            describe "multiple tables" $ do 
                it "without having" $ do 
                    let q = P.Select P.Wildcard (Just from) P.All
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing, P.Table "problem" $ Just "P" ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "P.category", "problem.state" ] Nothing
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        columns = projection <$> (extractQueryInfo q)
                    columns `shouldBe` [["number"], ["state", "category"]]
                it "with having" $ do 
                    let q = P.Select P.Wildcard (Just from) P.All
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing, P.Table "problem" $ Just "P" ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "P.category" ] having
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        having = Just $ P.Having $ P.Operator $ P.Plus (P.Identifier "incident.description") (P.Identifier "problem.state")
                        columns = projection <$> (extractQueryInfo q)
                    columns `shouldBe` [["number", "description"], ["state", "category"]]

tableInfo :: TableInfo -> (Table, Alias)
tableInfo info = case info of 
    Table { table = t, alias = a} -> (t, a)