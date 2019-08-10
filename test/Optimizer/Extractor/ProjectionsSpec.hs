module Optimizer.Extractor.ProjectionsSpec where 

import Test.Hspec

import Optimizer.Extractor.Projections
import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import qualified Data.Either as E

spec :: Spec
spec = do 
    describe "extract from columns" $ do 
        it "wildcard" $ do 
            let cols = P.Wildcard

            extractFromColumns cols `shouldSatisfy` E.isLeft
        it "multiple columns" $ do 
            let cols = P.Columns 
                    [ P.Column (P.Identifier "apple") Nothing 
                    , P.Column (P.Identifier "tree.orange") Nothing
                    , P.Column (P.Operator $ P.Plus (P.Identifier "tree.count") (P.Identifier "age")) Nothing
                    ]
                result = extractFromColumns cols
                expected = Right $ 
                    [ (Nothing, "apple")
                    , (Just "tree", "orange")
                    , (Just "tree", "count")
                    , (Nothing, "age")
                    ]
            result `shouldBe` expected 
    describe "extract from tables" $ do 
        it "multiple single tables" $ do 
            let tables = 
                    [ P.Table "incident" Nothing
                    , P.Table "problem" $ Just "P"
                    ]
                result = extractFromTables tables
                expected = Right []
            result `shouldBe` expected
        it "joins" $ do 
            let tables =
                    [ P.Join P.Inner 
                        ( P.Join P.Inner 
                            (P.Table "incident" Nothing)
                            (P.Table "problem" Nothing)
                            ("problem.state", "incident.state")
                        )
                        (P.Table "change" Nothing)
                        ("change.state", "problem.state")
                    ] 
                result = extractFromTables tables 
                expected = Right $ 
                    [ (Just "problem", "state")
                    , (Just "incident", "state")
                    , (Just "change", "state")
                    , (Just "problem", "state")
                    ]
            result `shouldBe` expected
        it "tables and joins" $ do 
            let tables = 
                    [ P.Table "sc_task" Nothing
                    , P.Join P.Inner 
                        ( P.Join P.Inner 
                            (P.Table "incident" Nothing)
                            (P.Table "problem" Nothing)
                            ("problem.state", "incident.state")
                        )
                        (P.Table "change" Nothing)
                        ("change.state", "problem.state")
                    , P.Table "request" Nothing
                    ]
                result = extractFromTables tables
                expected = Right $ 
                    [ (Just "problem", "state")
                    , (Just "incident", "state")
                    , (Just "change", "state")
                    , (Just "problem", "state")
                    ]
            result `shouldBe` expected
        it "invalid join" $ do 
            let tables = 
                    [ P.Join P.Inner 
                        ( P.Join P.Inner 
                            (P.Table "incident" Nothing)
                            (P.Table "problem" Nothing)
                            ("change.state", "incident.state")
                        )
                        (P.Table "change" Nothing)
                        ("change.state", "problem.state")
                    ] 
            extractFromTables tables `shouldSatisfy` E.isLeft
    describe "validate columns streams" $ do 
        describe "errors detected" $ do 
            let tmap = Map.fromList 
                    [ ("tree", True)
                    , ("bush", False)
                    , ("shrub", True)
                    ]
                amap = Map.fromList 
                    [ ("T", "tree")
                    , ("B", "bush")
                    ]
                info = (tmap, amap)
            it "maintains invalidation" $ do 
                let stream = Left "apple needs an alias"
                validate info stream `shouldSatisfy` E.isLeft
            it "detects when no tables are available despite untagged columns existing" $ do 
                let stream = Right $
                        [ (Nothing, "apple")
                        ]
                validate (Map.empty, Map.empty) stream `shouldSatisfy` E.isLeft
            it "detects when multiple tables are in query, but columns are not tagged" $ do 
                let stream = Right $ 
                        [ (Nothing, "apple") ]
                validate info stream `shouldSatisfy` E.isLeft
            it "detects when an alias needs to be used instead of tablename to disambiguate a column" $ do 
                let stream = Right $ 
                        [ (Just "tree", "orange")
                        ]
                validate info stream `shouldSatisfy` E.isLeft
            it "detects unknown aliases" $ do 
                let stream = Right $ 
                        [ (Just "Q", "orange")
                        ]
                validate info stream `shouldSatisfy` E.isLeft
        describe "valid streams pass" $ do 
            let tmap = Map.fromList 
                    [ ("tree", True)
                    , ("bush", False)
                    , ("shrub", True)
                    ]
                amap = Map.fromList 
                    [ ("T", "tree")
                    , ("B", "bush")
                    ]
                info = (tmap, amap)
            it "allows usage of multiple valid aliases" $ do 
                let stream = Right $ 
                        [ (Just "T", "orange")
                        , (Just "bush", "strawberry")
                        ]
                validate info stream `shouldSatisfy` E.isRight

        

