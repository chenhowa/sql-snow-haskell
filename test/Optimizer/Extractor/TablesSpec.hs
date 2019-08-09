module Optimizer.Extractor.TablesSpec where 

import Test.Hspec

import Optimizer.Extractor.Tables
import qualified Parser.Syntax as P
import Data.Either as E

spec :: Spec
spec = do 
    describe "extracts tables from single tables" $ do 
        it "multiple tables" $ do 
            let tables = [P.Table "incident" Nothing, P.Table "problem" $ Just "P"]
                result = extract tables
                expected = 
                    TableExtraction
                        { tables = 
                            [ [("incident", Nothing)]
                            , [("problem", Just "P")]
                            ]
                        }
            result `shouldBe` expected
        it "multiple joins" $ do 
            let tables = 
                    [ P.Join P.Inner 
                        (P.Join P.Inner 
                            (P.Table "incident" $ Nothing)
                            (P.Table "problem" $ Just "P")
                            ("state", "state")
                        )
                        (P.Table "change" $ Just "C")
                        ("category", "category")
                    , P.Join P.Inner 
                        (P.Join P.Inner 
                            (P.Table "req_item" $ Nothing)
                            (P.Table "sc_task" $ Just "S")
                            ("state", "state")
                        )
                        (P.Table "request" $ Just "R")
                        ("category", "category")
                    ]
                result = extract tables 
                expected = 
                    TableExtraction 
                        { tables = 
                            [ [("incident", Nothing), ("problem", Just "P" ), ("change", Just "C")]
                            , [("req_item", Nothing), ("sc_task", Just "S"), ("request", Just "R")]
                            ]
                        }
            result `shouldBe` expected
        it "join and table" $ do 
            let tables = 
                    [ P.Join P.Inner 
                        (P.Join P.Inner 
                            (P.Table "incident" $ Nothing)
                            (P.Table "problem" $ Just "P")
                            ("state", "state")
                        )
                        (P.Table "change" $ Just "C")
                        ("category", "category")
                    , P.Table "request" $ Just "R"
                    ]
                result = extract tables
                expected = 
                    TableExtraction 
                        { tables = 
                            [ [("incident", Nothing), ("problem", Just "P"), ("change", Just "C")]
                            , [ ("request", Just "R")]
                            ]
                        }
            result `shouldBe` expected
    describe "processing table stream" $ do 
        describe "detects errors in the table stream" $ do 
            it "no join - using aliases multiple times" $ do 
                let extraction = TableExtraction 
                        { tables = 
                            [ [("incident", Just "P")]
                            , [("problem", Just "P")]
                            ]
                        }
                    result = validate extraction 
                result `shouldSatisfy` E.isLeft
            it "no join - an alias cannot be the name of a table" $ do 
                let extraction = TableExtraction
                        { tables = 
                            [ [("incident", Just "I")]
                            , [("problem", Just "incident")]
                            ]
                        } 
                validate extraction `shouldSatisfy` E.isLeft
            describe "join" $ do 
                it "if a table occurs multiple times, each occurence is aliased" $ do 
                    let extraction_1 = TableExtraction 
                            { tables = 
                                [ [("incident", Nothing), ("problem", Just "P"), ("incident", Just "I")]

                                ]
                            }
                        extraction_2 = TableExtraction 
                            { tables = 
                                [ [("incident", Just "I"), ("problem", Just "P"), ("incident", Nothing )]
                                ]
                            }
                    validate extraction_1 `shouldSatisfy` E.isLeft
                    validate extraction_2 `shouldSatisfy` E.isLeft
                it "an alias cannot be used twice within the same JOIN clause" $ do 
                    let extraction = TableExtraction 
                            { tables = 
                                [ [ ("incident", Just "I"), ("problem", Just "I")]
                                ]
                            }
                    validate extraction `shouldSatisfy` E.isLeft
                it "an alias cannot be the name of a table" $ do 
                    let extraction = TableExtraction 
                            { tables = 
                                [ [ ("incident", Just "problem"), ("problem", Just "P")]
                                ]
                            }
                    validate extraction `shouldSatisfy` E.isLeft
        describe "all valid streams pass validation" $ do 
            it "join - multiple tables with no aliases" $ do 
                let extraction = TableExtraction 
                        { tables = 
                            [ [("incident", Nothing), ("problem", Nothing)]
                            ]
                        }
                validate extraction `shouldSatisfy` E.isRight
            it "no join - multiple table with no aliases" $ do 
                let extraction = TableExtraction 
                        { tables = 
                            [ [("incident", Nothing)]
                            , [("problem", Nothing)]
                            ]
                        }
                validate extraction `shouldSatisfy` E.isRight
                