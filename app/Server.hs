{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}


module Server where


import Servant
import Data.Aeson
import Data.Aeson.Types
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp

data Program = Program 
    { program :: String
    }
    deriving (Eq, Show, Generic)

instance ToJSON Program

--type ProgramAPI = "compiler" :> QueryParam "program" String :> Get '[JSON] Program
type ProgramAPI =    
                "queryplan" :> Get '[JSON] Program
                :<|> "compiler" :> QueryParam "withprogram" String :> Get '[JSON] Program



testProgram :: Program 
testProgram = Program { program = "hi there I'm a test" }

testQueryPlan :: Program
testQueryPlan = Program { program = "hi i should be a query plan" }


server :: Server ProgramAPI
server = 
        return testQueryPlan
        :<|> testProgramWithQuery

        where
            testProgramWithQuery :: Maybe String -> Handler Program
            testProgramWithQuery prog = case prog of 
                Just str -> return testProgram { program = (program testProgram  <> " " <> str) }
                Nothing -> return testProgram

programAPI :: Proxy ProgramAPI
programAPI = Proxy

app :: Application
app =  serve programAPI server

runApp :: IO ()
runApp = run 8081 app