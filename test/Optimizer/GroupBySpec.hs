module Optimizer.GroupBySpec where

import Test.Hspec

--import Optimizer.GroupBy
import qualified Parser.Syntax as P

spec :: Spec
spec = do 
    describe "extract group by information" $ do 
        describe "without having" $ do 
            it "no group by columns" $ do 
                pending

            it "multiple group columns" $ do 
                pending

        describe "with having" $ do 
            it "temp" $ do 
                pending






