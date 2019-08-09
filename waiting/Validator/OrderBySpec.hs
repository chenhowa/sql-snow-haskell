module Validator.OrderBySpec where 

import Test.Hspec

import Validator.OrderBy
import qualified Parser.Syntax as P

spec :: Spec
spec = do 
    describe "error" $ do 
        it "rejects sorting of any kind" $ do 
            let orderBy = P.OrderBy [] Nothing
                result = validateOrderBy orderBy
            in  result `shouldSatisfy` isJust


