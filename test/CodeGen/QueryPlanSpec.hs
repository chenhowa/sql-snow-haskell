module CodeGen.QueryPlanSpec where

import Test.Hspec
import Control.Monad.State
import qualified Text.StringTemplate as T
import qualified System.Process as P
import qualified System.Exit as E

import CodeGen.QueryPlan

spec :: Spec
spec = do 
    describe "Test code generation from query plan" $ do
        it "table access" $ do 
            let plan = Read "incident"
                generated = generate plan
                forParser = "var t = " <> generated
            generated `shouldBe` (T.toString $
                 T.setManyAttrib [("table", "incident")]  readTemplate)
            lintResult <- liftIO (validateJS forParser)
            err lintResult `shouldBe` ""
            output lintResult `shouldBe` ""
            succeeded lintResult `shouldBe` True
        it "projection" $ do
            let plan = Projection (Read "incident") [("number", "u_number"), ("u_name", "u_name")] 
                generated = generate plan
                forParser = "var t = " <> generated
            generated `shouldBe` (T.toString $
                 T.setManyAttrib 
                    [ ( "source", generate (Read "incident"))
                    , ( "restrictions"
                      , T.toString $ T.setManyAttrib 
                            [ ("columns", concat 
                                [ "number: tuple.getValue(\'u_number\'),\n"
                                , "u_name: tuple.getValue(\'u_name\'),"
                                ])
                            ] restrictionTemplate
                      )
                    ] 
                            projectionTemplate )      
            lintResult <- liftIO (validateJS forParser)
            err lintResult `shouldBe` ""
            output lintResult `shouldBe` ""
            succeeded lintResult `shouldBe` True
        it "selection" $ do 
            let plan = Selection (Read "incident") ["apple", "banana"]
                generated = generate plan
                forParser = "var t = " <> generated
            generated `shouldBe` (T.toString $
                T.setManyAttrib [("source", generate (Read "incident"))]
                        selectionTemplate)
            lintResult <- liftIO (validateJS forParser)
            err lintResult `shouldBe` ""
            output lintResult `shouldBe` ""
            succeeded lintResult `shouldBe` True
        it "sort" $ do 
            let plan = Sort (Read "incident") Ascending "number"
                generated = generate plan
                forParser = "var t = " <> generated
            generated `shouldBe` (T.toString $
                T.setManyAttrib 
                    [("source", generate (Read "incident"))
                    , ("desc", "false")
                    , ("column", "number")
                    ]
                            sortTemplate)
            lintResult <- liftIO (validateJS forParser)
            err lintResult `shouldBe` ""
            output lintResult `shouldBe` ""
            succeeded lintResult `shouldBe` True
        it "join" $ do 
            let plan = Join (Read "incident") (Read "problem") 
                        ["incident.sys_id > problem.sys_id"]
                generated = generate plan 
                forParser = "var t = " <> generated
            generated `shouldBe` (T.toString $
                T.setManyAttrib 
                        [ ("source_1", generate (Read "incident"))
                        , ("source_2", generate (Read "problem"))
                        ]
                        joinTemplate)
            lintResult <- liftIO (validateJS forParser)
            err lintResult `shouldBe` ""
            output lintResult `shouldBe` ""
            succeeded lintResult `shouldBe` True


validateJS :: String -> IO (E.ExitCode, String, String)
validateJS program = 
    P.readProcessWithExitCode "node" ["test/javascript/esprima.js", program] ""

succeeded :: (E.ExitCode, String, String) -> Bool
succeeded (e, _, _) = e == E.ExitSuccess

output :: (E.ExitCode, String, String) -> String
output (_, o, _) = o

err :: (E.ExitCode, String, String) -> String
err (_, _, e) = e