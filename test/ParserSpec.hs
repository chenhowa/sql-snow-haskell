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
                        (S.Select $ S.Columns [Column "what" Nothing])
            it "alias" $ do 
                parse [ T.Select, T.Identifier "what", T.As, T.Identifier "W" ] `shouldBe` 
                        (S.Select $ S.Columns [Column "what" $ Just "W"])
                parse [ T.Select, T.Identifier "what", T.Identifier "W" ] `shouldBe` 
                        (S.Select $ S.Columns [Column "what" $ Just "W"])
        describe "multiple columns" $ do 
            it "no alias" $ do 
                parse [ T.Select, T.Identifier "what", T.Comma, T.Identifier "why" ] `shouldBe` 
                        (S.Select $ S.Columns [Column "why" Nothing, Column "what" Nothing])
            it "alias" $ do 
                parse [ T.Select, T.Identifier "what", 
                                T.Identifier "W", T.Comma, 
                                T.Identifier "why", T.Identifier "Y" ] `shouldBe` 
                        (S.Select $ S.Columns [Column "why" $ Just "Y", Column "what" $ Just "W" ])
                parse [ T.Select, T.Identifier "what", T.As, T.Identifier "W", T.Comma, 
                                T.Identifier "why", T.As, T.Identifier "Y" ] `shouldBe` 
                        (S.Select $ S.Columns [Column "why" $ Just "Y", Column "what" $ Just "W" ])

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