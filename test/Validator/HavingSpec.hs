module Validator.HavingSpec where

import Test.Hspec

import Validator.Having
import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map

spec :: Spec
spec = do 
    describe "errors" $ do 
        it "alias does not exist" $ do 
            let groupBy = P.GroupBy $ P.Function "CONCAT" [P.Identifier "P.number", P.Identifier "I.number"]
                knownTables = Map.fromList 
                    [ ("problem", True)
                    , ("incident", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("P", "problem")
                    ]
                result = validateWhereColumns knownTables knownAliases groupBy 
            in  result `shouldSatisfy` isJust
        it "table does not exist" $ do 
            let groupBy  = P.GroupBy $ P.Function "CONCAT" [P.Identifier "P.number", P.Identifier "incident.number"]
                knownTables = Map.fromList 
                    [ ("problem", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("P", "problem")
                    ]
                result = validateWhereColumns knownTables knownAliases groupBy
            in  result `shouldSatisfy` isJust
    describe "success" $ do 
        it "only aliases - all correct" $ do 
            let groupBy = P.GroupBy $ P.Function "CONCAT" [P.Identifier "P.number", P.Identifier "I.number"]
                knownTables = Map.fromList 
                    [ ("problem", True)
                    , ("incident", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("P", "problem")
                    , ("I", "incident")
                    ]
                result = validateWhereColumns knownTables knownAliases groupBy
            in  result `shouldSatisfy` isNothing
        it "only tables - all correct" $ do 
            let groupBy = P.GroupBy $ P.Function "CONCAT" [P.Identifier "problem.number", P.Identifier "incident.number"]
                knownTables = Map.fromList 
                    [ ("problem", True)
                    , ("incident", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("P", "problem")
                    , ("I", "incident")
                    ]
                result = validateWhereColumns knownTables knownAliases groupBy
            in  result `shouldSatisfy` isNothing
