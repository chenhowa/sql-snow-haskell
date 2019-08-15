module Optimizer.Extractor.AggregationsSpec where

import Test.Hspec

import Optimizer.Extractor.Aggregations
import qualified Optimizer.Extractor.Tables as Tables
import qualified Optimizer.Extractor.Selections as S
import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import qualified Data.Either as E

spec :: Spec
spec = do 
    describe "extracts aggregation info" $ do 
        let tmap = Map.fromList 
                [ ("incident", False)
                , ("problem", False)
                , ("change", False)
                ]
            amap = Map.fromList 
                [ ("I", "incident")
                , ("P", "problem")
                , ("C", "change")
                ]
            tableInfo = (tmap, amap)
        it "without having" $ do 
            let groupBy = P.GroupBy gb Nothing 
                gb = 
                    [ "I.state"
                    , "P.substate"
                    ]
                expected = Right $ AggInfo 
                    { cols = [("I", "state"), ("P", "substate")]
                    , selections = []
                    }
            extract tableInfo groupBy `shouldBe` expected
        it "with having" $ do 
            let groupBy = P.GroupBy gb having
                gb = 
                    [ "I.state"
                    , "problem.substate"
                    ]
                having = Just $ P.Having exp
                exp = 
                    P.Operator 
                        ( P.GT
                            (P.Function "COUNT" [P.Identifier "incident.category"])
                            (P.Function "COUNT" [P.Identifier "P.category"]) 
                        )
                expected = Right $ AggInfo 
                    { cols = [("I", "state"), ("problem", "substate")]
                    , selections = 
                        [ S.SelectionInfo 
                            { S.tables = [("incident", Just "I"), ("problem", Nothing)]
                            , S.expr = exp
                            }
                        ]
                    }
            extract tableInfo groupBy `shouldBe` expected
    describe "detects errors in aggregation" $ do 
        it "stuff" $ do 
            pending