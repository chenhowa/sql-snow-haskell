module Optimizer.TableInfoSpec where 

import Test.Hspec

import Optimizer.TableInfo
import qualified Parser.Syntax as P
import qualified Data.Either as E

spec :: Spec
spec = do
    describe "failure" $ do 
        it "does not generate on non-select queries" $ do
            let q = P.Union P.All selectWildcard selectWildcard
                selectWildcard = P.Select P.Wildcard Nothing P.All
            extractInfoFromQuery q `shouldSatisfy` E.isLeft
    describe "success" $ do 
        it "extracts the used tables from a FROM clause" $ do 
            let q = P.Select columns (Just from) P.All
                columns = P.Columns [ P.Column (P.Identifier "incident.state") Nothing]
                from = P.FromClause
                        { P.tables = 
                            [ P.Table "incident" Nothing
                            , P.Join P.Inner (P.Table "problem" $ Just "P") (P.Table "sc_task" $ Just "S") ("P.sys_id", "S.sys_id")
                            ]
                        , P.where_ = Nothing
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing
                        , P.limit = Nothing
                        }
                tables = (fmap . fmap) tableInfo  (extractInfoFromQuery q)
            tables `shouldBe` Right [("incident", ""), ("problem", "P"), ("sc_task", "S")]
        describe "extracts the used columns from a WHERE clause" $ do 
            it "when there is only one table" $ do 
                let q = P.Select cols (Just from) P.All
                    cols = P.Columns [ P.Column (P.Identifier "state") Nothing]
                    from = P.FromClause 
                        { P.tables = [ P.Table "incident" Nothing ]
                        , P.where_ = Just $ P.Operator $ P.Plus (P.Identifier "incident.number") (P.Identifier "category")
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing 
                        , P.limit = Nothing
                        }
                    columns = (fmap . fmap) projection (extractInfoFromQuery q)
                columns `shouldBe` Right  [["state", "number", "category"] ]
            it "when there are multiple tables" $ do 
                let q = P.Select cols (Just from) P.All
                    cols = P.Columns [ P.Column (P.Identifier "incident.state") Nothing]
                    from = P.FromClause 
                        { P.tables = [ P.Table "incident" Nothing, P.Table "problem" $ Just "P" ]
                        , P.where_ = Just $ P.Operator $ P.Plus (P.Identifier "problem.number") (P.Identifier "P.category")
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing 
                        , P.limit = Nothing
                        }
                    columns = (fmap . fmap) projection (extractInfoFromQuery q)
                columns `shouldBe` Right  [["state"], ["number", "category"]]
        describe "extracts the used columns from a group-by clause" $ do 
            describe "one table" $ do 
                it "without having" $ do 
                    let q = P.Select cols (Just from) P.All
                        cols = P.Columns [ P.Column (P.Identifier "state") Nothing]
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "category" ] Nothing
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        columns = (fmap . fmap) projection (extractInfoFromQuery q)
                    columns `shouldBe` Right [["state", "number", "category"]]
                it "with having" $ do 
                    let q = P.Select cols (Just from) P.All
                        cols = P.Columns [ P.Column (P.Identifier "state") Nothing]
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "category" ] having
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        having = Just $ P.Having $ P.Operator $ P.Plus (P.Identifier "incident.description") (P.Identifier "state")
                        columns = (fmap . fmap) projection (extractInfoFromQuery q)
                    columns `shouldBe` Right [["state", "number", "category", "description" ]]
            describe "multiple tables" $ do 
                it "without having" $ do 
                    let q = P.Select cols (Just from) P.All
                        cols = P.Columns [ P.Column (P.Identifier "incident.state") Nothing]
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing, P.Table "problem" $ Just "P" ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "P.category", "problem.state" ] Nothing
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        columns = (fmap . fmap) projection (extractInfoFromQuery q)
                    columns `shouldBe` Right [["state", "number"], ["category", "state"]]
                it "with having" $ do 
                    let q = P.Select cols (Just from) P.All
                        cols = P.Columns [ P.Column (P.Identifier "incident.state") Nothing]
                        from = P.FromClause 
                            { P.tables = [ P.Table "incident" Nothing, P.Table "problem" $ Just "P" ]
                            , P.where_ = Nothing
                            , P.groupBy = Just $ P.GroupBy [ "incident.number", "P.category" ] having
                            , P.orderBy = Nothing 
                            , P.limit = Nothing
                            }
                        having = Just $ P.Having $ P.Operator $ P.Plus (P.Identifier "incident.description") (P.Identifier "problem.state")
                        columns = (fmap . fmap) projection (extractInfoFromQuery q)
                    columns `shouldBe` Right [["state", "number", "description"], ["category", "state"]]
        describe "extract columns from SELECT output" $ do 
            it "one table" $ do 
                let q = P.Select columns from P.All
                    columns = P.Columns [ P.Column (P.Identifier "number") Nothing, P.Column (P.Identifier "incident.category") Nothing ]
                    from = Just $ P.FromClause
                        { P.tables = [ P.Table "incident" Nothing ]
                        , P.where_ = Nothing 
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing 
                        , P.limit = Nothing 
                        }
                    cs = (fmap . fmap) projection (extractInfoFromQuery q)
                cs `shouldBe` Right [["number", "category"]]
            it "multiple tables" $ do 
                let q = P.Select columns from P.All
                    columns = P.Columns [ P.Column (P.Identifier "P.number") Nothing, P.Column (P.Identifier "problem.state") Nothing, 
                                                P.Column (P.Identifier "incident.category") Nothing ]
                    from = Just $ P.FromClause
                        { P.tables = [ P.Table "incident" Nothing, P.Table "problem" $ Just "P" ]
                        , P.where_ = Nothing 
                        , P.groupBy = Nothing 
                        , P.orderBy = Nothing 
                        , P.limit = Nothing 
                        }
                    cs = (fmap . fmap) projection (extractInfoFromQuery q)
                cs `shouldBe` Right [["category"], ["number", "state"]]
        describe "extract columns from ORDER BY" $ do 
            it "when there is only one table" $ do 
                let q = P.Select P.Wildcard (Just from) P.All
                    from = P.FromClause 
                        { P.tables = [ P.Table "incident" Nothing ]
                        , P.where_ = Nothing
                        , P.groupBy = Nothing 
                        , P.orderBy = Just $ P.OrderBy ["number", "incident.category"] Nothing 
                        , P.limit = Nothing
                        }
                extractInfoFromQuery q `shouldSatisfy` E.isLeft
            it "when there are multiple tables" $ do 
                let q = P.Select P.Wildcard (Just from) P.All
                    from = P.FromClause 
                        { P.tables = [ P.Table "incident" $ Just "i", P.Table "problem" $ Just "p" ]
                        , P.where_ = Nothing
                        , P.groupBy = Nothing 
                        , P.orderBy = Just $ P.OrderBy ["i.number", "problem.state", "p.category"] Nothing
                        , P.limit = Nothing
                        }
                extractInfoFromQuery q `shouldSatisfy` E.isLeft

tableInfo :: TableInfo -> (Table, Alias)
tableInfo info = case info of 
    Table { table = t, alias = a} -> (t, a)