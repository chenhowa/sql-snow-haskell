module Optimizer.Extractor.SelectionsSpec where 

import Test.Hspec

import Optimizer.Extractor.Selections
import qualified Optimizer.Extractor.Tables as Tables
import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import qualified Data.Either as E

spec :: Spec
spec = do 
    describe "extracts selection from" $ do 
        it "no table comparison" $ do 
            let select = P.Operator $ P.Equals (number "1") (number "2")
                expected = 
                    [ SelectionInfo
                        { tables = []
                        , expr = select
                        }

                    ]
            extract select `shouldBe` Right expected
            
        describe "single comparison" $ do 
            it "equality between column and constant" $ do 
                let select = P.Operator $ P.Equals (id_ "incident.state") (number "1")
                    expected = 
                        [ SelectionInfo { tables = [("incident", Nothing)], expr = select}

                        ]
                extract select `shouldBe` Right expected
            it "equality between same-table columns" $ do 
                let select = P.Operator $ P.Equals (id_ "incident.state") (id_ "state")
                    expected = 
                        [ SelectionInfo { tables = [ ("incident", Nothing)], expr = select }

                        ]
                extract select `shouldBe` Right expected
            it "equality between different-table columns" $ do 
                let select = P.Operator $ P.Equals (id_ "incident.state") (id_ "problem.state") 
                    expected = 
                        [ SelectionInfo { tables = [ ("incident", Nothing), ("problem", Nothing) ], expr = select}
                        ]
                extract select `shouldBe` Right expected
        describe "multiple selections" $ do 
            it "multiple ANDs" $ do 
                let select = P.Operator $ P.And 
                                (expr1)
                                ( P.Operator $ P.And
                                    (expr2)
                                    (expr3)
                                )
                    expr1 = P.Operator $ P.Equals (id_ "incident.state") (number "1")
                    expr2 = P.Operator $ P.Equals (id_ "problem.category") (id_ "incident.category")
                    expr3 = P.Operator $ P.Equals (number "1") (number "2")
                    expected = 
                        [ SelectionInfo { tables = [("incident", Nothing)], expr = expr1}
                        , SelectionInfo { tables = [("problem", Nothing), ("incident", Nothing)], expr = expr2}
                        , SelectionInfo { tables = [], expr = expr3}
                        ]
                extract select `shouldBe` Right expected
            describe "multiple ORs" $ do 
                it "with constant comparisons" $ do 
                    let select = P.Operator $ P.Or expr1 expr2
                        expr1 = P.Operator $ P.Equals (number "1") (number "2")
                        expr2 = P.Operator $ P.Equals (number "2") (number "3")
                        expected = 
                            [ SelectionInfo { tables = [], expr = select }
                            ]
                    extract select `shouldBe` Right expected
                it "with comparisons between constants and same-table columns" $ do 
                    let select = P.Operator $ P.Or expr1 expr2
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (number "1")
                        expr2 = P.Operator $ P.Equals (id_ "incident.category") (number "1")
                        expected =
                            [ SelectionInfo { tables = [("incident", Nothing)], expr = select }

                            ]
                    extract select `shouldBe` Right expected
                it "with comparisons between same-table columns" $ do 
                    let select = P.Operator $ P.Or expr1 expr2
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (id_ "incident.substate")
                        expr2 = P.Operator $ P.Equals (id_ "incident.category") (id_ "incident.subcategory")
                        expected =
                            [ SelectionInfo { tables = [("incident", Nothing)], expr = select }
                            ]
                    extract select `shouldBe` Right expected
                it "with comparisons between multi-table columns" $ do 
                    let select = P.Operator $ P.Or expr1 expr2
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (id_ "problem.substate")
                        expr2 = P.Operator $ P.Equals (id_ "incident.category") (id_ "change.subcategory")
                        expected =
                            [ SelectionInfo { tables = [("incident", Nothing), ("problem", Nothing), ("change", Nothing)], expr = select }
                            ]
                    extract select `shouldBe` Right expected
                it "mixed comparison types" $ do 
                    let select = P.Operator $ P.Or 
                                    (expr1) 
                                    ( P.Operator $ P.Or 
                                        expr2 
                                        expr3
                                    )
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (number "1")
                        expr2 = P.Operator $ P.Equals (id_ "problem.category") (id_ "incident.category")
                        expr3 = P.Operator $ P.Equals (number "1") (number "2")
                        expected = 
                            [ SelectionInfo { tables = [], expr = select}
                            ]
                    extract select `shouldBe` Right expected
            describe "AND and nested ORs" $ do 
                it "with constant comparisons" $ do 
                    let select = P.Operator $ P.And 
                                    expr1
                                    (P.Operator $ P.Or 
                                        expr2 
                                        expr3 
                                    )
                        expr1 = P.Operator $ P.Equals (number "1") (number "2")
                        expr2 = P.Operator $ P.Equals (number "0") (number "2")
                        expr3 = P.Operator $ P.Equals (number "5") (number "2")
                        expected = 
                            [ SelectionInfo {tables = [], expr = select}
                            ]
                    extract select `shouldBe` Right expected
                it "with comparisons between constants and same-table columns" $ do 
                    let select = P.Operator $ P.And 
                                    expr1
                                    (P.Operator $ P.Or 
                                        expr2 
                                        expr3 
                                    )
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (number "2")
                        expr2 = P.Operator $ P.Equals (number "0") (id_ "incident.substate")
                        expr3 = P.Operator $ P.Equals (id_ "incident.category") (number "2")
                        expected = 
                            [ SelectionInfo {tables = [("incident", Nothing)], expr = select}
                            ]
                    extract select `shouldBe` Right expected
                it "with comparisons between multi-table columns" $ do 
                    let select = P.Operator $ P.And 
                                    expr1
                                    (P.Operator $ P.Or 
                                        expr2 
                                        expr3 
                                    )
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (id_ "problem.state")
                        expr2 = P.Operator $ P.Equals (id_ "problem.substate") (id_ "incident.substate")
                        expr3 = P.Operator $ P.Equals (id_ "incident.category") (id_ "change.category")
                        expected = 
                            [ SelectionInfo {tables = [("incident", Nothing), ("problem", Nothing)], expr = expr1 }
                            , SelectionInfo {tables = [("problem", Nothing), ("incident", Nothing), ("change", Nothing)], expr = P.Operator $ P.Or expr2 expr3 }
                            ]
                    extract select `shouldBe` Right expected
                it "mixed comparison types" $ do 
                    let select = P.Operator $ P.And 
                                    expr1
                                    (P.Operator $ P.Or 
                                        expr2 
                                        expr3 
                                    )
                        expr1 = P.Operator $ P.Equals (number "1") (id_ "problem.state")
                        expr2 = P.Operator $ P.Equals (id_ "problem.substate") (id_ "incident.substate")
                        expr3 = P.Operator $ P.Equals (id_ "incident.category") (id_ "incident.subcategory")
                        expected = 
                            [ SelectionInfo {tables = [("problem", Nothing)], expr = expr1 }
                            , SelectionInfo {tables = [("problem", Nothing), ("incident", Nothing)], expr = P.Operator $ P.Or expr2 expr3 }
                            ]
                    extract select `shouldBe` Right expected
            describe "OR and nested ANDs" $ do 
                it "with constant comparisons" $ do 
                    let select = P.Operator $ P.Or 
                                    expr1
                                    (P.Operator $ P.And 
                                        expr2
                                        expr3
                                    )
                        expr1 = P.Operator $ P.Equals (number "1") (number "2")
                        expr2 = P.Operator $ P.Equals (number "0") (number "2")
                        expr3 = P.Operator $ P.Equals (number "5") (number "2")
                        expected = 
                            [ SelectionInfo {tables = [], expr = select}
                            ]
                    extract select `shouldBe` Right expected
                it "with comparisons between constants and same-table columns" $ do 
                    let select = P.Operator $ P.Or 
                                    expr1
                                    (P.Operator $ P.And 
                                        expr2
                                        expr3
                                    )
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (number "2")
                        expr2 = P.Operator $ P.Equals (number "0") (id_ "incident.substate")
                        expr3 = P.Operator $ P.Equals (id_ "incident.category") (number "2")
                        expected = 
                            [ SelectionInfo {tables = [("incident", Nothing)], expr = select}
                            ]
                    extract select `shouldBe` Right expected
                it "with comparisons between multi-table columns" $ do 
                    let select = P.Operator $ P.Or 
                                    expr1
                                    (P.Operator $ P.And 
                                        expr2
                                        expr3
                                    )
                        expr1 = P.Operator $ P.Equals (id_ "incident.state") (id_ "problem.state")
                        expr2 = P.Operator $ P.Equals (id_ "problem.substate") (id_ "incident.substate")
                        expr3 = P.Operator $ P.Equals (id_ "incident.category") (id_ "change.category")
                        expected = 
                            [ SelectionInfo {tables = [("incident", Nothing), ("problem", Nothing), ("change", Nothing)], expr = select}
                            ]
                    extract select `shouldBe` Right expected
                it "mixed comparison types" $ do 
                    let select = P.Operator $ P.Or 
                                    expr1
                                    (P.Operator $ P.And 
                                        expr2
                                        expr3
                                    )
                        expr1 = P.Operator $ P.Equals (number "1") (id_ "problem.state")
                        expr2 = P.Operator $ P.Equals (id_ "problem.substate") (id_ "incident.substate")
                        expr3 = P.Operator $ P.Equals (id_ "incident.category") (id_ "incident.subcategory")
                        expected = 
                            [ SelectionInfo {tables = [("incident", Nothing), ("problem", Nothing)], expr = select}
                            ]
                    extract select `shouldBe` Right expected
    describe "errors detected" $ do 
        it "pending" $ do 
            pending

number :: String -> P.Expr
number str = P.Constant $ P.Number str

id_ :: String -> P.Expr
id_ str = P.Identifier str