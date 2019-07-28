module ParserSpec where 


import Test.Hspec
import Parser (parse)
import Parser.Syntax as S
import Lexer.Tokens as T
import Parser.Expressions
import Parser.Expressions as E

spec :: Spec
spec = do 
    describe "select" $ do 
        it "wildcard" $ do 
            parse [ T.Select, T.Asterisk ] `shouldBe` (S.Select S.Wildcard)
        describe "one column" $ do
            it "no alias" $ do 
                parse [ T.Select, T.Identifier "what" ] `shouldBe` 
                        (S.Select $ S.Columns [Column (S.Identifier "what") Nothing])
            it "alias" $ do 
                parse [ T.Select, T.Identifier "what", T.As, T.Identifier "W" ] `shouldBe` 
                        (S.Select $ S.Columns [Column (S.Identifier "what") $ Just "W"])
                parse [ T.Select, T.Identifier "what", T.Identifier "W" ] `shouldBe` 
                        (S.Select $ S.Columns [Column (S.Identifier "what") $ Just "W"])
        describe "multiple columns" $ do 
            it "no alias" $ do 
                parse [ T.Select, T.Identifier "what", T.Comma, T.Identifier "why" ] `shouldBe` 
                        (S.Select $ S.Columns [Column (S.Identifier "why") Nothing, Column (S.Identifier "what") Nothing])
            it "alias" $ do 
                parse [ T.Select, T.Identifier "what", 
                                T.Identifier "W", T.Comma, 
                                T.Identifier "why", T.Identifier "Y" ] `shouldBe` 
                        (S.Select $ S.Columns [Column (S.Identifier "why") $ Just "Y", Column (S.Identifier "what") $ Just "W" ])
                parse [ T.Select, T.Identifier "what", T.As, T.Identifier "W", T.Comma, 
                                T.Identifier "why", T.As, T.Identifier "Y" ] `shouldBe` 
                        (S.Select $ S.Columns [Column (S.Identifier "why") $ Just "Y", Column (S.Identifier "what") $ Just "W" ])

    describe "from" $ do 
        describe "one table" $ do 
            it "no alias" $ do 
                parse [ T.From, T.Identifier "incident"]
                    `shouldBe` S.From [Table "incident" Nothing]
            it "alias" $ do 
                parse [ T.From, T.Identifier "incident", T.Identifier "In"]
                    `shouldBe` S.From [Table "incident" $ Just "In"]
                parse [ T.From, T.Identifier "incident", T.As, T.Identifier "In"]
                    `shouldBe` S.From [Table "incident" $ Just "In"]
        describe "multiple tables" $ do
            it "no alias" $ do 
                parse [ T.From, T.Identifier "incident", 
                    T.Comma, T.Identifier "problem"]
                    `shouldBe` S.From [Table "problem" Nothing, Table "incident" Nothing]
            it "alias" $ do 
                parse [ T.From, T.Identifier "incident", T.Identifier "In",
                    T.Comma, T.Identifier "problem", T.Identifier "P"]
                    `shouldBe` S.From [Table "problem" $ Just "P", Table "incident" $ Just "In"]
                parse [ T.From, T.Identifier "incident", T.As, T.Identifier "In",
                        T.Comma, T.Identifier "problem", T.As, T.Identifier "P"]
                    `shouldBe` S.From [Table "problem" $ Just "P", Table "incident" $ Just "In"]

    describe "expression" $ do 
        describe "function with args" $ do 
            it "column name" $ do
                let initial = [ T.Select, T.Identifier "COUNT", T.LeftParen]
                    expr = [ T.Identifier "name" ]
                    end = [ T.RightParen ]
                parse (initial <> expr <> end)
                    `shouldBe` ( S.Select . S.Columns $ 
                        [ S.Column (S.Function "COUNT" [S.Identifier "name"]) Nothing ] )
        describe "constant" $ do 
            it "boolean" $ do 
                let initial = [ T.Select ]
                    expr = [ T.Constant $ T.Boolean T.TrueVal ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( S.Select . S.Columns $ 
                        [ S.Column (S.Constant $ S.Boolean S.TrueVal) Nothing ] )
            it "string" $ do 
                let initial = [ T.Select ]
                    expr = [ T.Constant $ T.String "hey" ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( S.Select . S.Columns $ 
                        [ S.Column (S.Constant $ S.String "hey") Nothing ] )
            it "integer" $ do 
                let initial = [ T.Select ]
                    expr = [ T.Constant $ T.Integer "5" ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( S.Select . S.Columns $ 
                        [ S.Column (S.Constant $ S.Number "5") Nothing ] )
            it "float" $ do 
                let initial = [ T.Select ]
                    expr = [ T.Constant $ T.Float "5.0" ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( S.Select . S.Columns $ 
                        [ S.Column (S.Constant $ S.Number "5.0") Nothing ] )
        describe "operators" $ do 
            describe "single" $ do 
                let five = T.Constant $ T.Integer "5"
                    six = T.Constant $ T.Integer "6"
                it "addition" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.Plus, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (plus (number "5") (number "6")) Nothing ] )
                it "subtraction" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.Minus, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (minus (number "5") (number "6")) Nothing ] )
                it "division" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.FloatDivide, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (divide (number "5") (number "6")) Nothing])
                it "modulo" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.Modulo, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (modulo (number "5") (number "6")) Nothing])
                it "multiply" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.Asterisk, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (multiply (number "5") (number "6")) Nothing])
                it "equals" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.Equals, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (equals (number "5") (number "6")) Nothing])
                it "not equals" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.NotEquals, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (notEquals (number "5") (number "6")) Nothing])
                it "<" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.LT, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (lessThan (number "5") (number "6")) Nothing])
                it "<=" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.LTE, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (lessThanOrEquals (number "5") (number "6")) Nothing])
                it "> " $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.GT, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (greaterThan (number "5") (number "6")) Nothing])
                it ">=" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.GTE, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (greaterThanOrEquals (number "5") (number "6")) Nothing])
                it "and" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.And, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (E.and (number "5") (number "6")) Nothing])
                it "or" $ do 
                    let initial = [ T.Select ]
                        expr = [ five, T.Or, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (E.or (number "5") (number "6")) Nothing])
                it "not" $ do 
                    let initial = [ T.Select ]
                        expr = [ T.Not, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (E.not (number "6")) Nothing])
                it "neg" $ do 
                    let initial = [ T.Select ]
                        expr = [ T.Minus, six ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (neg (number "6")) Nothing])
            describe "multiple" $ do 
                let five = T.Constant $ T.Integer "5"
                    six = T.Constant $ T.Integer "6"
                    seven = T.Constant $ T.Integer "7"
                    nFive = number "5"
                    nSix = number "6"
                    nSeven = number "7"
                describe "arithmetic" $ do 
                    it "+ -" $ do
                        let initial = [T.Select]
                            expr = [ five, T.Plus, six, T.Minus, seven ]
                        parse (initial <> expr)
                            `shouldBe` ( columns $ 
                            [ S.Column (minus (plus nFive nSix) nSeven) Nothing])
                    it "* /" $ do
                        let initial = [T.Select]
                            expr = [ five, T.Asterisk, six, T.FloatDivide, seven ]
                        parse (initial <> expr)
                            `shouldBe` ( columns $ 
                            [ S.Column (divide (multiply nFive nSix) nSeven) Nothing])
                    it "+ /" $ do
                        let initial = [T.Select]
                            expr = [ five, T.Plus, six, T.FloatDivide, seven ]
                        parse (initial <> expr)
                            `shouldBe` ( columns $ 
                            [ S.Column (plus nFive (divide nSix nSeven) ) Nothing])
        describe "nested functions" $ do 
            it "two functions" $ do 
                let initial = [T.Select]
                    expr = [ tid "floor", T.LeftParen, tid "Count", T.LeftParen, tid "name", T.RightParen, T.RightParen]
                parse (initial <> expr) `shouldBe` (columns $ 
                    [ S.Column (S.Function "floor" [S.Function "Count" [S.Identifier "name"]]) Nothing])

columns :: [S.Column] -> S.Query 
columns = S.Select . S.Columns

tid :: String -> T.Token
tid str = T.Identifier str