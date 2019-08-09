module Validator.OutputColumnSpec where 

import Test.Hspec

import Validator.OutputColumn
import qualified Parser.Syntax as P

spec :: Spec
spec = do 
    describe "errors detected" $ do 
        describe "just identifiers" $ do 
            it "detects aliases that don't exist" $ do
                let columns = 
                        [ P.Column (P.Function "CONCAT" [P.Identifier "P.number"]) Nothing
                        , P.Column (P.Function "LEN" [P.Identifier "C.number", P.Identifier "P.state"]) Nothing
                        ] 
                    knownTables = Map.fromList
                        [("problem", True)]
                    knownAliases = Map.fromList 
                        [("P", "problem")]
                    result = validateOutputColumns knownTables knownAliases columns 
                in  result `shouldSatisfy` isJust
            it "detects usage of tables that don't exists" $ do 
                let columns = 
                        [ P.Column (P.Function "CONCAT" [P.Identifier "P.number"]) Nothing
                        , P.Column (P.Function "LEN" [P.Identifier "incident.number", P.Identifier "problem.state"]) Nothing
                        ] 
                    knownTables = Map.fromList
                        [("problem", True)]
                    knownAliases = Map.fromList 
                        [("P", "problem")]
                    result = validateOutputColumns knownTables knownAliases columns 
                in  result `shouldSatisfy` isJust
        describe "just exprs" $ do 
            it "detects aliases that don't exist" $ do
                let columns = 
                        [ P.Column (P.Identifier "P.number") Nothing
                        , P.Column (P.Identifier "C.number") Nothing
                        ] 
                    knownTables = Map.fromList
                        [("problem", True)]
                    knownAliases = Map.fromList 
                        [("P", "problem")]
                    result = validateOutputColumns knownTables knownAliases columns 
                in  result `shouldSatisfy` isJust
            it "detects usage of tables that don't exists" $ do 
                let columns = 
                        [ P.Column (P.Identifier "P.number") Nothing
                        , P.Column (P.Identifier "incident.number") Nothing
                        ] 
                    knownTables = Map.fromList
                        [("problem", True)]
                    knownAliases = Map.fromList 
                        [("P", "problem")]
                    result = validateOutputColumns knownTables knownAliases columns 
                in  result `shouldSatisfy` isJust
    describe "success detected" $ do 
        it "only aliases - all aliases are correct" $ do 
            let columns = 
                    [ P.Column (P.Function "CONCAT" [P.Identifier "P.number"]) Nothing
                    , P.Column (P.Function "LEN" [P.Identifier "C.number", P.Identifier "P.state"]) Nothing
                    ] 
                knownTables = Map.fromList
                    [("problem", True)]
                knownAliases = Map.fromList 
                    [ ("P", "problem")]
                    , ("C", "change")
                    ]
                result = validateOutputColumns knownTables knownAliases columns 
            in  result `shouldSatisfy` isNothing
        it "only tables - all table names are correct" $ do 
            let columns = 
                    [ P.Column (P.Function "CONCAT" [P.Identifier "problem.number"]) Nothing
                    , P.Column (P.Function "LEN" [P.Identifier "change.number", P.Identifier "P.state"]) Nothing
                    ] 
                knownTables = Map.fromList
                    [ ("problem", True)
                    , ("change", True)
                    ]
                knownAliases = Map.fromList 
                    [ ("P", "problem")]
                    , ("C", "change")
                    ]
                result = validateOutputColumns knownTables knownAliases columns 
            in  result `shouldSatisfy` isNothing








