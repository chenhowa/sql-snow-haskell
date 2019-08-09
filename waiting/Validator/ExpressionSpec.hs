module Parser.Validator.ExpressionSpec where

import Test.Hspec
import Parser.Validator.Expression
import Control.Monad.State
import qualified Parser.Syntax as S
import qualified Parser.Expressions as E

spec :: Spec
spec = do 
    describe "operator validation" $ do 
        describe "plus" $ do 
            it "success" $ do 
                let expr = S.Plus (E.number "5") (E.number "6")
                    initial = initialOpState expr
                    expected = 
                            ( Number
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.Plus (E.number "5") E.true
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "minus" $ do 
            it "success" $ do 
                let expr = S.Minus (E.number "5") (E.number "6")
                    initial = initialOpState expr
                    expected = 
                            ( Number
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.Minus (E.number "5") E.true
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "multiply" $ do 
            it "success" $ do 
                let expr = S.Multiply (E.number "5") (E.number "6")
                    initial = initialOpState expr
                    expected = 
                            ( Number
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.Multiply (E.number "5") E.true
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "divide" $ do 
            it "success" $ do 
                let expr = S.FloatDivide (E.number "5") (E.number "6")
                    initial = initialOpState expr
                    expected = 
                            ( Number
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.FloatDivide (E.number "5") E.true
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "modulo" $ do 
            it "success" $ do 
                let expr = S.Modulo (E.number "5") (E.number "6")
                    initial = initialOpState expr
                    expected = 
                            ( Number
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.Modulo (E.number "5") E.true
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "and" $ do 
            it "success" $ do 
                let expr = S.And (E.true) (E.true)
                    initial = initialOpState expr
                    expected = 
                            ( Boolean
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.And (E.number "5") E.true
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "or" $ do 
            it "success" $ do 
                let expr = S.Or (E.true) (E.true)
                    initial = initialOpState expr
                    expected = 
                            ( Boolean
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.Or (E.number "5") E.true
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "not" $ do 
            it "success" $ do 
                let expr = S.Not (E.true) 
                    initial = initialOpState expr
                    expected = 
                            ( Boolean
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.Not (E.number "5") 
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        describe "neg" $ do 
            it "success" $ do 
                let expr = S.Neg (E.number "5") 
                    initial = initialOpState expr
                    expected = 
                            ( Number
                            , ValidOpState { opErrors="", op=expr }
                            )
                runState validateOpTypes initial `shouldBe` expected
            it "failure" $ do 
                let expr = S.Neg (E.true) 
                    initial = initialOpState expr
                    expected = 
                        ( Unknown
                        , ValidOpState { opErrors="", op=expr}
                        )
                runState validateOpTypes initial `shouldBe` expected
        
        


initialOpState :: S.OperatorType -> ValidOpState
initialOpState oper = ValidOpState 
    { opErrors = ""
    , op = oper
    }

