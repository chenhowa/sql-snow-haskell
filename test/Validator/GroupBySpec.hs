module Validator.GroupBySpec where 

import Test.Hspec

import Validator.GroupBy
import qualified Parser.Syntax as P
import qualified Data.Map.Strict as S 

spec :: Spec
spec = do 
    describe "errors" $ do 
        it "uses nonexistent aliases" $ do
            let groupBy = P.GroupBy ["I.number", "C.number"] Nothing
                knownTables = Map.fromList 
                    [("incident", True)]
                knownAliases = Map.fromList 
                    [ ("I", "incident")
                    ]
                result = validateGroupBy knownTables knownAliases groupBy 
            in  result `shouldSatisfy` isJust 
        it "uses nonexistent tables" $ do 
            let groupBy = P.GroupBy ["incident.number", "problem.number"] Nothing
                knownTables = Map.fromList 
                    [("incident", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("I", "incident")
                    , ("P", "problem")
                    ]
                result = validateGroupBy knownTables knownAliases groupBy 
            in  result `shouldSatisfy` isJust 
        it "uses unqualified columns with multiple tables" $ do 
            let groupBy = P.GroupBy ["I.number", "state"] Nothing
                knownTables = Map.fromList 
                    [("incident", True)
                    , ("problem", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("I", "incident")
                    , ("P", "problem")
                    ]
                result = validateGroupBy knownTables knownAliases groupBy 
            in  result `shouldSatisfy` isJust 
    describe "success" $ do 
        it "only aliases - all correct" $ do 
            let groupBy = P.GroupBy ["I.number", "C.number"] Nothing
                knownTables = Map.fromList 
                    [("incident", True)
                    , ("change", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("I", "incident")
                    , ("C", "change")
                    ]
                result = validateGroupBy knownTables knownAliases groupBy 
            in  result `shouldSatisfy` isNothing

        it "only tables - all correct" $ do 
            let groupBy = P.GroupBy ["incident.number", "change.number"] Nothing
                knownTables = Map.fromList 
                    [("incident", True)
                    , ("change", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("I", "incident")
                    , ("C", "change")
                    ]
                result = validateGroupBy knownTables knownAliases groupBy 
            in  result `shouldSatisfy` isNothing