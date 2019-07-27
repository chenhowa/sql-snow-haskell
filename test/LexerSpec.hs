module LexerSpec where 

import Test.Hspec

import Lexer.Tokens
import qualified Lexer.Tokens as T 
import qualified Lexer as L


spec :: Spec
spec = do 
    describe "validate each token" $ do 
        it "select" $ do 
            L.alexScanTokens "SELECT" `shouldBe` [Select]
            L.alexScanTokens "select" `shouldBe` [Select]
        it "from" $ do 
            L.alexScanTokens "FROM" `shouldBe` [From]
            L.alexScanTokens "from" `shouldBe` [From]
        it "where" $ do 
            L.alexScanTokens "WHERE" `shouldBe` [Where]
            L.alexScanTokens "where" `shouldBe` [Where]
        it "group by" $ do 
            L.alexScanTokens "GROUP   BY" `shouldBe` [GroupBy]
            L.alexScanTokens "group   by" `shouldBe` [GroupBy]
        it "having" $ do 
            L.alexScanTokens "HAVING" `shouldBe` [Having]
            L.alexScanTokens "having" `shouldBe` [Having]
        it "in" $ do 
            L.alexScanTokens "IN" `shouldBe` [In]
            L.alexScanTokens "in" `shouldBe` [In]


        it "distinct" $ do 
            L.alexScanTokens "DISTINCT" `shouldBe` [Distinct]
            L.alexScanTokens "distinct" `shouldBe` [Distinct]
        it "limit" $ do 
            L.alexScanTokens "LIMIT" `shouldBe` [Limit]
            L.alexScanTokens "limit" `shouldBe` [Limit]
        it "order by" $ do 
            L.alexScanTokens "ORDER   BY" `shouldBe` [OrderBy]
            L.alexScanTokens "order   by" `shouldBe` [OrderBy]
        it "ascending" $ do 
            L.alexScanTokens "ASC" `shouldBe` [Ascending]
            L.alexScanTokens "asc" `shouldBe` [Ascending]
        it "descending" $ do 
            L.alexScanTokens "DESC" `shouldBe` [Descending]
            L.alexScanTokens "desc" `shouldBe` [Descending]
        it "union" $ do 
            L.alexScanTokens "UNION" `shouldBe` [Union]
            L.alexScanTokens "union" `shouldBe` [Union]
        it "intersect" $ do 
            L.alexScanTokens "INTERSECT" `shouldBe` [Intersect]
            L.alexScanTokens "intersect" `shouldBe` [Intersect]
        it "all" $ do 
            L.alexScanTokens "ALL" `shouldBe` [All]
            L.alexScanTokens "all" `shouldBe` [All]
        it "left" $ do 
            L.alexScanTokens "LEFT" `shouldBe` [T.Left]
            L.alexScanTokens "left" `shouldBe` [T.Left]
        it "right" $ do 
            L.alexScanTokens "RIGHT" `shouldBe` [T.Right]
            L.alexScanTokens "right" `shouldBe` [T.Right]
        it "inner" $ do 
            L.alexScanTokens "INNER" `shouldBe` [Inner]
            L.alexScanTokens "inner" `shouldBe` [Inner]
        it "outer" $ do 
            L.alexScanTokens "OUTER" `shouldBe` [Outer]
            L.alexScanTokens "outer" `shouldBe` [Outer]
        it "natural" $ do 
            L.alexScanTokens "NATURAL" `shouldBe` [Natural]
            L.alexScanTokens "natural" `shouldBe` [Natural]
        it "join" $ do 
            L.alexScanTokens "JOIN" `shouldBe` [Join]
            L.alexScanTokens "join" `shouldBe` [Join]
        it "on" $ do 
            L.alexScanTokens "ON" `shouldBe` [On]
            L.alexScanTokens "on" `shouldBe` [On]
        it "+" $ do 
            L.alexScanTokens "+" `shouldBe` [Plus]
        it "-" $ do 
            L.alexScanTokens "-" `shouldBe` [Minus]
        it "*" $ do 
            L.alexScanTokens "*" `shouldBe` [Asterisk]
        it "/" $ do 
            L.alexScanTokens "/" `shouldBe` [FloatDivide]
        it "%" $ do 
            L.alexScanTokens "%" `shouldBe` [Modulo]
        it "=" $ do 
            L.alexScanTokens "=" `shouldBe` [Equals]
        it "!=" $ do 
            L.alexScanTokens "!=" `shouldBe` [NotEquals]
        it "<" $ do 
            L.alexScanTokens "<" `shouldBe` [T.LT]
        it "<=" $ do 
            L.alexScanTokens "<=" `shouldBe` [LTE]
        it ">" $ do 
            L.alexScanTokens ">" `shouldBe` [T.GT]
        it ">=" $ do 
            L.alexScanTokens ">=" `shouldBe` [GTE]
        it "not" $ do 
            L.alexScanTokens "NOT" `shouldBe` [Not]
            L.alexScanTokens "not" `shouldBe` [Not]
        it "and" $ do 
            L.alexScanTokens "AND" `shouldBe` [And]
            L.alexScanTokens "and" `shouldBe` [And]
        it "or" $ do 
            L.alexScanTokens "OR" `shouldBe` [Or]
            L.alexScanTokens "or" `shouldBe` [Or]
        it "as" $ do 
            L.alexScanTokens "AS" `shouldBe` [As]
            L.alexScanTokens "as" `shouldBe` [As]
        describe "identifier" $ do 
            it "letters" $ do
                L.alexScanTokens "hello" `shouldBe` [Identifier "hello"]
            it "letters and underscores" $ do 
                L.alexScanTokens "hello_j" `shouldBe` [Identifier "hello_j"]
            it "letters, underscores, numbers" $ do
                L.alexScanTokens "HEllo_8" `shouldBe` [Identifier "HEllo_8"]
        it "dotwalk" $ do 
            L.alexScanTokens "apple.pie" `shouldBe` [Dotwalk "apple.pie"]
            L.alexScanTokens "apple.pur_ple.pie" `shouldBe` [Dotwalk "apple.pur_ple.pie"]
        it ")" $ do 
            L.alexScanTokens ")" `shouldBe` [RightParen]
        it "(" $ do 
            L.alexScanTokens "(" `shouldBe` [LeftParen]
        it "," $ do 
            L.alexScanTokens "," `shouldBe` [Comma]
        it "block comment" $ do 
            L.alexScanTokens "/* I am block */" `shouldBe` [BlockComment " I am block "]
        describe "constant" $ do 
            it "true" $ do 
                L.alexScanTokens "TRUE" `shouldBe` [Constant $ Boolean TrueVal]
                L.alexScanTokens "true" `shouldBe` [Constant $ Boolean TrueVal]
            it "false" $ do 
                L.alexScanTokens "FALSE" `shouldBe` [Constant $ Boolean FalseVal]
                L.alexScanTokens "false" `shouldBe` [Constant $ Boolean FalseVal]
            it "null" $ do 
                L.alexScanTokens "NULL" `shouldBe` [Constant $ Boolean Null]
                L.alexScanTokens "null" `shouldBe` [Constant $ Boolean Null]
    it "validate maximum munch" $ do 
        L.alexScanTokens "descending" `shouldBe` [ Identifier "descending" ]
    it "whitespace is ignored" $ do 
        L.alexScanTokens "desc  hello \t SELECT \n from" `shouldBe` [ Descending, Identifier "hello", Select, From ]