module CodeGen.QueryPlanSpec where

import Test.Hspec
import Control.Monad.State
import qualified Text.StringTemplate as T

import CodeGen.QueryPlan

spec :: Spec
spec = do 
    describe "Test code generation from query plan" $ do
        it "table access" $ do 
            let plan = Read "incident"
            generate plan `shouldBe` (T.toString $
                 T.setManyAttrib [("table", "incident")]  readTemplate)
        it "projection" $ do
            let plan = Projection (Read "incident") ["number", "u_name"] 
            generate plan `shouldBe` (T.toString $
                 T.setManyAttrib [("source", generate (Read "incident"))] 
                            projectionTemplate )      
        it "selection" $ do 
            let plan = Selection (Read "incident") ["apple", "banana"]
            generate plan `shouldBe` (T.toString $
                T.setManyAttrib [("source", generate (Read "incident"))]
                        selectionTemplate)
        it "sort" $ do 
            let plan = Sort (Read "incident") Ascending "number"
            generate plan `shouldBe` (T.toString $
                T.setManyAttrib [("source", generate (Read "incident"))]
                            sortTemplate)
        it "join" $ do 
            let plan = Join (Read "incident") (Read "problem") 
                        ["incident.sys_id > problem.sys_id"]
            generate plan `shouldBe` (T.toString $
                T.setManyAttrib 
                        [ ("source_1", generate (Read "incident"))
                        , ("source_2", generate (Read "problem"))
                        ]
                        joinTemplate)
