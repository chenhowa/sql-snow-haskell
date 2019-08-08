module Optimizer.JoinInfoSpec where 


import Test.Hspec

import Optimizer.JoinInfo
import qualified Parser.Syntax as P

spec :: Spec
spec = do
    describe "Join Info" $ do 
        it "sanity check" $ do
            let q = P.Select P.Wildcard from P.All
                from = Just $ P.FromClause 
                    { P.tables = []
                    , P.where_ = Nothing
                    , P.groupBy = Nothing
                    , P.orderBy = Nothing
                    , P.limit = Nothing
                    }
                expected = []
            extractQueryInfo q `shouldBe` expected
        it "pulls join info out" $ do 
            let q = P.Select P.Wildcard from P.All
                from = Just $ P.FromClause 
                    { P.tables = 
                        [ P.Join P.LeftOuter 
                            (P.Join P.FullOuter
                                (P.Join P.Inner (P.Table "inc" Nothing) (P.Table "prob" Nothing) ("inc.sys_id","prob.first_reported")) 
                                (P.Table "change" Nothing)
                                ("change.number", "prob.first_reported")
                            ) 
                            (P.Table "cat_task" Nothing) 
                            ("cat_task.request","change.request")
                        ]
                    , P.where_ = Nothing
                    , P.groupBy = Nothing
                    , P.orderBy = Nothing
                    , P.limit = Nothing
                    }
                expected = 
                    [ Join 
                        { table1 = "cat_task"
                        , table2 = "change"
                        , onCondition = Equals ("cat_task", "request") ("change", "request")
                        , joinType = P.LeftOuter
                        }
                    , Join 
                        { table1 = "change"
                        , table2 = "prob"
                        , onCondition = Equals ("change", "number") ("prob", "first_reported")
                        , joinType = P.FullOuter
                        }
                    , Join 
                        { table1 = "inc"
                        , table2 = "prob"
                        , onCondition = Equals ("inc", "sys_id") ("prob", "first_reported")
                        , joinType = P.Inner
                        }
                    ]
            extractQueryInfo q `shouldBe` expected
        it "registers cross products" $ do 
            let q = P.Select P.Wildcard from P.All
                from = Just $ P.FromClause 
                    { P.tables = 
                        [ P.Table "incident" Nothing
                        , P.Table "problem" Nothing
                        ]
                    , P.where_ = Nothing
                    , P.groupBy = Nothing
                    , P.orderBy = Nothing
                    , P.limit = Nothing
                    }
                expected = 
                    [ CrossProduct "incident"
                    , CrossProduct "problem"
                    ]
            extractQueryInfo q `shouldBe` expected
