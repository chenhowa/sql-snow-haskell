module Parser.ValidatorSpec where 



import Test.Hspec
import Parser.Validator
import Control.Monad.State
import qualified Parser.Syntax as S

spec :: Spec
spec = do 
    describe "putTables" $ do 
        it "gets tables" $ do 
            let initial = initialValidState (S.Select S.Wildcard from S.All)
                ts = [ S.Table "incident" $ Just "inc", S.Table "problem" $ Just "prob"]
                from = Just $ mkFromClause ts Nothing Nothing Nothing Nothing
            tables (execState putTables initial) `shouldBe` ts

mkFromClause :: [S.Table] -> Maybe S.Where -> Maybe S.GroupBy -> Maybe S.OrderBy -> Maybe S.Limit -> S.FromClause
mkFromClause ts w g o l = S.FromClause
    { S.tables = ts 
    , S.where_ = w 
    , S.groupBy = g 
    , S.orderBy = o 
    , S.limit = l
    }