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
            parse [ T.Select, T.Asterisk ] `shouldBe` (S.Select S.Wildcard Nothing S.All)
        describe "one column" $ do
            it "no alias" $ do 
                parse [ T.Select, T.Identifier "what" ] `shouldBe` 
                        (columns [Column (S.Identifier "what") Nothing])
            it "alias" $ do 
                parse [ T.Select, T.Identifier "what", T.As, T.Identifier "W" ] `shouldBe` 
                        (columns [Column (S.Identifier "what") $ Just "W"])
                parse [ T.Select, T.Identifier "what", T.Identifier "W" ] `shouldBe` 
                        (columns [Column (S.Identifier "what") $ Just "W"])
        describe "multiple columns" $ do 
            it "no alias" $ do 
                parse [ T.Select, T.Identifier "what", T.Comma, T.Identifier "why" ] `shouldBe` 
                        (columns [Column (S.Identifier "why") Nothing, Column (S.Identifier "what") Nothing])
            it "alias" $ do 
                parse [ T.Select, T.Identifier "what", 
                                T.Identifier "W", T.Comma, 
                                T.Identifier "why", T.Identifier "Y" ] `shouldBe` 
                        (columns [Column (S.Identifier "why") $ Just "Y", Column (S.Identifier "what") $ Just "W" ])
                parse [ T.Select, T.Identifier "what", T.As, T.Identifier "W", T.Comma, 
                                T.Identifier "why", T.As, T.Identifier "Y" ] `shouldBe` 
                        (columns [Column (S.Identifier "why") $ Just "Y", Column (S.Identifier "what") $ Just "W" ])
        it "distinct" $ do 
            let expr = [ T.Select, T.Distinct, T.Asterisk]
                expected = S.Select S.Wildcard Nothing S.Distinct
            parse expr `shouldBe` expected

    describe "from" $ do 
        describe "one table" $ do 
            it "no alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, T.Identifier "incident"]
                    `shouldBe` from [Table "incident" Nothing]
            it "alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, T.Identifier "incident", T.Identifier "In"]
                    `shouldBe` from [Table "incident" $ Just "In"]
                parse [ T.Select, T.Asterisk, T.From, T.Identifier "incident", T.As, T.Identifier "In"]
                    `shouldBe` from [Table "incident" $ Just "In"]
        describe "multiple tables" $ do
            it "no alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, T.Identifier "incident", 
                    T.Comma, T.Identifier "problem"]
                    `shouldBe` from [Table "problem" Nothing, Table "incident" Nothing]
            it "alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, T.Identifier "incident", T.Identifier "In",
                    T.Comma, T.Identifier "problem", T.Identifier "P"]
                    `shouldBe` from [Table "problem" $ Just "P", Table "incident" $ Just "In"]
                parse [ T.Select, T.Asterisk, T.From, T.Identifier "incident", T.As, T.Identifier "In",
                        T.Comma, T.Identifier "problem", T.As, T.Identifier "P"]
                    `shouldBe` from [Table "problem" $ Just "P", Table "incident" $ Just "In"]
        it "with limit" $ do 
            let expr = [ T.Select, T.Asterisk, T.From, tid "incident", T.Limit, T.Integer "5"]
                expected = genLimit [ S.Table "incident" Nothing ] "5"
            parse expr `shouldBe` expected

    describe "expression" $ do 
        describe "function with args" $ do 
            it "column name" $ do
                let initial = [ T.Select, T.Identifier "COUNT", T.LeftParen]
                    expr = [ T.Identifier "name" ]
                    end = [ T.RightParen ]
                parse (initial <> expr <> end)
                    `shouldBe` ( columns 
                        [ S.Column (S.Function "COUNT" [S.Identifier "name"]) Nothing ] )
        describe "constant" $ do 
            it "boolean" $ do 
                let initial = [ T.Select ]
                    expr = [ T.TrueVal ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( columns 
                        [ S.Column (S.Constant $ S.Boolean S.TrueVal) Nothing ] )
            it "string" $ do 
                let initial = [ T.Select ]
                    expr = [ T.String "hey" ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( columns 
                        [ S.Column (S.Constant $ S.String "hey") Nothing ] )
            it "integer" $ do 
                let initial = [ T.Select ]
                    expr = [ T.Integer "5" ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( columns 
                        [ S.Column (S.Constant $ S.Number "5") Nothing ] )
            it "float" $ do 
                let initial = [ T.Select ]
                    expr = [ T.Float "5.0" ]
                    end = []
                parse (initial <> expr <> end)
                    `shouldBe` ( columns 
                        [ S.Column (S.Constant $ S.Number "5.0") Nothing ] )
        describe "operators" $ do 
            describe "single" $ do 
                let five = T.Integer "5"
                    six = T.Integer "6"
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
                let five = T.Integer "5"
                    six = T.Integer "6"
                    seven = T.Integer "7"
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
    describe "where" $ do 
        it "expression" $ do 
            let expr = [ T.Select, T.Asterisk, T.From, tid "incident", T.Where, five, T.LT, six]
                five = T.Integer "5"
                six = T.Integer "6"
                nFive = number "5"
                nSix = number "6"
            parse expr `shouldBe` (genWhere_ [S.Table "incident" Nothing] (lessThan nFive nSix))

    describe "group by" $ do 
        it "columns" $ do 
            let expr = [ T.Select, T.Asterisk, T.From, tid "incident", T.GroupBy, tid "category", T.Comma, tid "subcategory"]
            parse expr `shouldBe` (genGroupBy [S.Table "incident" Nothing] ["subcategory", "category"])
        it "alias table columns" $ do 
            let expr = [ T.Select, T.Asterisk, T.From, tid "incident", tid "In", T.GroupBy, tid "In.category", T.Comma, tid "In.subcategory"]
            parse expr `shouldBe` (genGroupBy [S.Table "incident" (Just "In")] ["In.subcategory", "In.category"])
    describe "having" $ do 
        it "expression" $ do 
            let expr = [ T.Select, T.Asterisk, T.From, tid "incident", T.GroupBy, tid "category", 
                                T.Having, tid "COUNT", T.LeftParen, T.Integer "5", T.RightParen]
                expected =  having [S.Table "incident" Nothing ] ["category"] (S.Function "COUNT" [five]) 
                five = number "5"
            parse expr `shouldBe` expected
    describe "order by" $ do 
        it "no direction" $ do 
            let expr = [ T.Select, T.Asterisk, T.From, tid "incident", T.OrderBy, tid "category"]
                expected = genOrderBy [S.Table "incident" Nothing] ["category"] Nothing
            parse expr `shouldBe` expected

genOrderBy :: [S.Table] -> [String] -> Maybe S.Direction -> S.Query 
genOrderBy ts ids dir = S.Select S.Wildcard ( Just (S.mkFromClause ts Nothing Nothing (Just (S.OrderBy ids Nothing)) Nothing) ) S.All

having :: [ S.Table ] -> [ String ] -> S.Expr -> S.Query
having ts ids expr = S.Select S.Wildcard ( Just (S.mkFromClause ts Nothing (Just $ S.GroupBy ids (Just $ S.Having expr)) Nothing Nothing) ) S.All

genGroupBy :: [ S.Table ] -> [ String ] -> S.Query
genGroupBy ts ids = S.Select S.Wildcard ( Just (S.mkFromClause ts Nothing (Just $ S.GroupBy ids Nothing) Nothing Nothing) ) S.All

genWhere_ :: [ S.Table ] -> Expr -> S.Query 
genWhere_ ts expr = S.Select S.Wildcard ( Just (S.mkFromClause ts (Just expr) Nothing Nothing Nothing) ) S.All

genLimit :: [S.Table] -> String -> S.Query 
genLimit tables lim = S.Select S.Wildcard (Just (S.mkFromClause tables Nothing Nothing Nothing (Just $ lim)))  S.All

from :: [ S.Table ] -> S.Query
from tables = S.Select S.Wildcard (Just (S.mkFromClause tables Nothing Nothing Nothing Nothing))  S.All

columns :: [S.Column] -> S.Query 
columns cols = S.Select ( S.Columns cols) Nothing S.All

tid :: String -> T.Token
tid str = T.Identifier str

sid :: String -> S.Expr
sid str = S.Identifier str