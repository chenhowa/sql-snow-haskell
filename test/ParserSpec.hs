module ParserSpec where 


import Test.Hspec
import Parser (parse)
import qualified Parser.Syntax as S
import Parser.Syntax (Column(..))
import qualified Lexer.Tokens as T
import Parser.Expressions
import qualified Parser.Expressions as E

spec :: Spec
spec = do 
    describe "union" $ do
        it "no modifier" $ do 
            let expr = [ T.LeftParen, T.Select, T.Asterisk, T.RightParen,  
                            T.Union, 
                            T.LeftParen, T.Select, T.Asterisk, T.RightParen]
                expected = S.Union S.Distinct selectWildcard selectWildcard
            parse expr `shouldBe` expected
        it "all" $ do
            let expr = [ T.LeftParen, T.Select, T.Asterisk, T.RightParen,  
                            T.Union, T.All,
                            T.LeftParen, T.Select, T.Asterisk, T.RightParen]
                expected = S.Union S.All selectWildcard selectWildcard
            parse expr `shouldBe` expected
    describe "intersect" $ do
        it "no modifier" $ do 
            let expr = [ T.LeftParen, T.Select, T.Asterisk, T.RightParen,  
                            T.Intersect, 
                            T.LeftParen, T.Select, T.Asterisk, T.RightParen]
                expected = S.Intersect S.Distinct selectWildcard selectWildcard
            parse expr `shouldBe` expected
        it "all" $ do
            let expr = [ T.LeftParen, T.Select, T.Asterisk, T.RightParen,  
                            T.Intersect, T.All,
                            T.LeftParen, T.Select, T.Asterisk, T.RightParen]
                expected = S.Intersect S.All selectWildcard selectWildcard
            parse expr `shouldBe` expected
    describe "select" $ do 
        it "wildcard" $ do 
            parse [ T.Select, T.Asterisk ] `shouldBe` selectWildcard
        describe "one column" $ do
            it "no alias" $ do 
                parse [ T.Select, tid "what" ] `shouldBe` 
                        (columns [Column (sid "what") Nothing])
            it "alias" $ do 
                parse [ T.Select, tid "what", T.As, tid "W" ] `shouldBe` 
                        (columns [Column (sid "what") $ Just "W"])
                parse [ T.Select, tid "what", tid "W" ] `shouldBe` 
                        (columns [Column (sid "what") $ Just "W"])
        describe "multiple columns" $ do 
            it "no alias" $ do 
                parse [ T.Select, tid "what", T.Comma, tid "why" ] `shouldBe` 
                        (columns [Column (sid "why") Nothing, Column (sid "what") Nothing])
            it "alias" $ do 
                parse [ T.Select, tid "what", 
                                tid "W", T.Comma, 
                                tid "why", tid "Y" ] `shouldBe` 
                        (columns [Column (sid "why") $ Just "Y", Column (sid "what") $ Just "W" ])
                parse [ T.Select, tid "what", T.As, tid "W", T.Comma, 
                                tid "why", T.As, tid "Y" ] `shouldBe` 
                        (columns [Column (sid "why") $ Just "Y", Column (sid "what") $ Just "W" ])
        it "distinct" $ do 
            let expr = [ T.Select, T.Distinct, T.Asterisk]
                expected = S.Select S.Wildcard Nothing S.Distinct
            parse expr `shouldBe` expected

    describe "from" $ do 
        describe "one table" $ do 
            it "no alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, tid "incident"]
                    `shouldBe` from [S.Table "incident" Nothing]
            it "alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, tid "incident", tid "In"]
                    `shouldBe` from [S.Table "incident" $ Just "In"]
                parse [ T.Select, T.Asterisk, T.From, tid "incident", T.As, tid "In"]
                    `shouldBe` from [S.Table "incident" $ Just "In"]
        describe "multiple tables" $ do
            it "no alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, tid "incident", 
                    T.Comma, tid "problem"]
                    `shouldBe` from [S.Table "problem" Nothing, S.Table "incident" Nothing]
            it "alias" $ do 
                parse [ T.Select, T.Asterisk, T.From, tid "incident", tid "In",
                    T.Comma, tid "problem", tid "P"]
                    `shouldBe` from [S.Table "problem" $ Just "P", S.Table "incident" $ Just "In"]
                parse [ T.Select, T.Asterisk, T.From, tid "incident", T.As, tid "In",
                        T.Comma, tid "problem", T.As, tid "P"]
                    `shouldBe` from [S.Table "problem" $ Just "P", S.Table "incident" $ Just "In"]
        it "with limit" $ do 
            let expr = [ T.Select, T.Asterisk, T.From, tid "incident", T.Limit, T.Integer "5"]
                expected = genLimit [ S.Table "incident" Nothing ] "5"
            parse expr `shouldBe` expected
        describe "joins" $ do 
            it "natural" $ do 
                let expr = [ T.Select, T.Asterisk, T.From, tid "inc", T.Natural, T.Join, tid "prob" ]
                    expected = from [ S.Natural (table "inc") (table "prob")]
                parse expr `shouldBe` expected
            it "left outer" $ do 
                let expr = [ T.Select, T.Asterisk, T.From, tid "inc", T.Left, T.Join, tid "prob", T.On, dw "inc.sys_id", T.Equals, dw "prob.first_reported" ]
                    expected = from [ S.Join S.LeftOuter (table "inc") (table "prob") ("inc.sys_id", "prob.first_reported") ]
                parse expr `shouldBe` expected
            it "right outer" $ do 
                let expr = [ T.Select, T.Asterisk, T.From, tid "inc", T.Right, T.Join, tid "prob", T.On, dw "inc.sys_id", T.Equals, dw "prob.first_reported" ]
                    expected = from [ S.Join S.RightOuter (table "inc") (table "prob") ("inc.sys_id", "prob.first_reported") ]
                parse expr `shouldBe` expected
            it "outer" $ do 
                let expr = [ T.Select, T.Asterisk, T.From, tid "inc", T.Outer, T.Join, tid "prob", T.On, dw "inc.sys_id", T.Equals, dw "prob.first_reported" ]
                    expected = from [ S.Join S.FullOuter (table "inc") (table "prob") ("inc.sys_id", "prob.first_reported") ]
                parse expr `shouldBe` expected
            it "inner" $ do 
                let expr = [ T.Select, T.Asterisk, T.From, tid "inc", T.Inner, T.Join, tid "prob", T.On, dw "inc.sys_id", T.Equals, dw "prob.first_reported" ]
                    expected = from [ S.Join S.Inner (table "inc") (table "prob") ("inc.sys_id", "prob.first_reported") ]
                parse expr `shouldBe` expected
            it "multiple" $ do 
                let expr = [ T.Select, T.Asterisk, T.From
                            , tid "inc", T.Inner, T.Join, tid "prob", T.On, dw "inc.sys_id", T.Equals, dw "prob.first_reported" 
                            , T.Natural, T.Join, tid "change"
                            , T.Left, T.Join, tid "cat_task", T.On, dw "cat_task.request", T.Equals, dw "change.request"
                            ]
                    expected = from [S.Join S.LeftOuter 
                                        (S.Natural 
                                            (S.Join S.Inner (S.Table "inc" Nothing) (S.Table "prob" Nothing) ("inc.sys_id","prob.first_reported")) 
                                            (S.Table "change" Nothing)
                                        ) 
                                        (S.Table "cat_task" Nothing) 
                                        ("cat_task.request","change.request")
                                    ]
                parse expr `shouldBe` expected
                

    describe "expression" $ do 
        describe "subquery" $ do 
            it "exists" $ do 
                let initial = [ T.Select, T.Asterisk, T.From, tid "inc", T.Where ]
                    expr = [ T.Exists, T.LeftParen, T.Select, T.Asterisk, T.RightParen]
                    expected = genWhere_ [S.Table "inc" Nothing ]
                                (S.SubQuery S.Exists selectWildcard)
                parse (initial <> expr) `shouldBe` expected
        describe "function with args" $ do 
            it "column name" $ do
                let initial = [ T.Select, tid "COUNT", T.LeftParen]
                    expr = [ tid "name" ]
                    end = [ T.RightParen ]
                parse (initial <> expr <> end)
                    `shouldBe` ( columns 
                        [ S.Column (S.Function "COUNT" [sid "name"]) Nothing ] )
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
                describe "in" $ do 
                    it "row" $ do 
                        let initial = [ T.Select, T.Asterisk, T.From, tid "incident"]
                            expr = [ T.Where, tid "number", T.In, T.LeftParen, T.Integer "5", T.RightParen ]
                            expected = genWhere_ [S.Table "incident" Nothing] 
                                            (S.Operator $ S.In (sid "number") (S.Row [number "5"]))
                        parse (initial <> expr) `shouldBe` expected
                    it "subquery" $ do 
                        let initial = [ T.Select, T.Asterisk, T.From, tid "incident"]
                            expr = [ T.Where, tid "number", T.In, T.LeftParen, T.Select, T.Asterisk, T.RightParen ]
                            expected = genWhere_ [S.Table "incident" Nothing] 
                                            (S.Operator $ S.In (sid "number") (S.Rows $ selectWildcard))
                        parse (initial <> expr) `shouldBe` expected
                describe "not in" $ do 
                    it "row" $ do 
                        let initial = [ T.Select, T.Asterisk, T.From, tid "incident"]
                            expr = [ T.Where, tid "number", T.NotIn, T.LeftParen, T.Integer "5", T.RightParen ]
                            expected = genWhere_ [S.Table "incident" Nothing] 
                                            (S.Operator $ S.NotIn (sid "number") (S.Row [number "5"]))
                        parse (initial <> expr) `shouldBe` expected
                    it "subquery" $ do 
                        let initial = [ T.Select, T.Asterisk, T.From, tid "incident"]
                            expr = [ T.Where, tid "number", T.NotIn, T.LeftParen, T.Select, T.Asterisk, T.RightParen ]
                            expected = genWhere_ [S.Table "incident" Nothing] 
                                            (S.Operator $ S.NotIn (sid "number") (S.Rows $ selectWildcard))
                        parse (initial <> expr) `shouldBe` expected
                it "all" $ do 
                    let initial = [ T.Select, T.Asterisk, T.From, tid "incident"]
                        expr = [ T.Where, T.All, T.LeftParen, T.Select, T.Asterisk, T.RightParen ]
                        expected = genWhere_ [S.Table "incident" Nothing ]
                                            (S.SubQuery S.QAll (selectWildcard) )
                    parse (initial <> expr ) `shouldBe` expected
                it "any" $ do 
                    let initial = [ T.Select, T.Asterisk, T.From, tid "incident"]
                        expr = [ T.Where, T.Any, T.LeftParen, T.Select, T.Asterisk, T.RightParen ]
                        expected = genWhere_ [S.Table "incident" Nothing ]
                                            (S.SubQuery S.QAny (selectWildcard) )
                    parse (initial <> expr ) `shouldBe` expected
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
                    [ S.Column (S.Function "floor" [S.Function "Count" [sid "name"]]) Nothing])
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

genWhere_ :: [ S.Table ] -> S.Expr -> S.Query 
genWhere_ ts expr = S.Select S.Wildcard ( Just (S.mkFromClause ts (Just expr) Nothing Nothing Nothing) ) S.All

genLimit :: [S.Table] -> String -> S.Query 
genLimit tables lim = S.Select S.Wildcard (Just (S.mkFromClause tables Nothing Nothing Nothing (Just $ lim)))  S.All

from :: [ S.Table ] -> S.Query
from tables = S.Select S.Wildcard (Just (S.mkFromClause tables Nothing Nothing Nothing Nothing))  S.All

columns :: [S.Column] -> S.Query 
columns cols = S.Select ( S.Columns cols) Nothing S.All

tid :: String -> T.Token
tid str = T.Identifier str

dw :: String -> T.Token
dw str = T.Dotwalk str

sid :: String -> S.Expr
sid str = S.Identifier str

selectWildcard :: S.Query
selectWildcard = S.Select S.Wildcard Nothing S.All


table :: String -> S.Table 
table str = S.Table str Nothing