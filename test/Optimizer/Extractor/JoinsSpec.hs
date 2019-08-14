module Optimizer.Extractor.JoinsSpec where 

import Test.Hspec

import Optimizer.Extractor.Joins
import qualified Optimizer.Extractor.Tables as Tables
import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import qualified Data.Either as E


spec :: Spec
spec = do 
    describe "extracts join info" $ do 
        it "one table" $ do 
            let tables = 
                    [ P.Table "incident" $ Just "I"

                    ]
                expected = Right []
            extract tables `shouldBe` expected
        it "one join" $ do 
            let tables = 
                    [ P.Table "tree" $ Just "T"
                    , P.Join P.Inner 
                        (P.Join P.FullOuter
                            (P.Table "incident" $ Just "I" )
                            (P.Table "problem" $ Nothing)
                            ("problem.state", "I.state")
                        )
                        (P.Table "change" $ Just "C")
                        ("C.state", "I.state")
                    ]
                expected = Right $ 
                    [ JoinInfo 
                        { joinOn = (("C", "state"), ("I", "state"))
                        , type_ = P.Inner
                        }
                    , JoinInfo 
                        { joinOn = (("problem", "state"), ("I", "state"))
                        , type_ = P.FullOuter
                        }
                    ]
            extract tables `shouldBe` expected
        it "multiple joins" $ do
            let tables = 
                    [ P.Table "tree" $ Just "T"
                    , P.Join P.Inner 
                        (P.Table "bush" $ Just "B")
                        (P.Join P.FullOuter
                            (P.Table "tree" $ Just "Tr" )
                            (P.Table "problem" $ Just "pr")
                            ("pr.state", "tree.state")
                        )
                        ("B.state", "Tr.state")
                    , P.Join P.Inner 
                        (P.Join P.FullOuter
                            (P.Table "incident" $ Just "I" )
                            (P.Table "problem" $ Nothing)
                            ("problem.state", "I.state")
                        )
                        (P.Table "change" $ Just "C")
                        ("C.state", "I.state")
                    ]
                expected = Right $ 
                    [ JoinInfo 
                        { joinOn = (("B", "state"), ("Tr", "state"))
                        , type_ = P.Inner
                        }
                    , JoinInfo 
                        { joinOn = (("pr", "state"), ("tree", "state"))
                        , type_ = P.FullOuter
                        }
                    , JoinInfo 
                        { joinOn = (("C", "state"), ("I", "state"))
                        , type_ = P.Inner
                        }
                    , JoinInfo 
                        { joinOn = (("problem", "state"), ("I", "state"))
                        , type_ = P.FullOuter
                        }
                    ]
            extract tables `shouldBe` expected

    describe "validates extracted join info against available tables" $ do 
        it "refuses joins on columns that aren't qualified with a source table/alias" $ do 
            let tables = 
                    [ P.Table "tree" $ Just "T"
                    , P.Join P.Inner 
                        (P.Join P.FullOuter
                            (P.Table "incident" $ Just "I" )
                            (P.Table "problem" $ Nothing)
                            ("problem.state", "state")
                        )
                        (P.Table "change" $ Just "C")
                        ("C.state", "I.state")
                    ]
            extract tables `shouldSatisfy` E.isLeft