module ParserSpec where 


import Test.Hspec
import Parser (parse)
import Parser.Syntax as S
import Lexer.Tokens as T

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
                it "addition" $ do 
                    let initial = [ T.Select ]
                        expr = [ T.Constant $ T.Integer "5", T.Plus, T.Constant $ T.Integer "6" ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (plus (number "5") (number "6")) Nothing ] )
                it "subtraction" $ do 
                    let initial = [ T.Select ]
                        expr = [ T.Constant $ T.Integer "5", T.Minus, T.Constant $ T.Integer "6" ]
                        end = []
                    parse (initial <> expr <> end)
                        `shouldBe` ( columns $ 
                            [ S.Column (minus (number "5") (number "6")) Nothing ] )
            describe "multiple" $ do 
                it "addition and division" $ do 
                    pending

        describe "nested functions" $ do 
            it "two functions" $ do 
                pending

columns :: [S.Column] -> S.Query 
columns = S.Select . S.Columns

plus :: S.Op -> S.Op -> S.Expr
plus op1 op2 = S.Operator $ S.Plus op1 op2

minus :: S.Op -> S.Op -> S.Expr
minus op1 op2 = S.Operator $ S.Minus op1 op2

boolean :: S.BooleanType -> S.Expr
boolean = S.Constant . S.Boolean

true :: S.Expr 
true = boolean S.TrueVal

false :: S.Expr
false = boolean S.FalseVal

null :: S.Expr
null = boolean S.Null

str :: String -> S.Expr
str = S.Constant . S.String

number :: String -> S.Expr
number = S.Constant . S.Number