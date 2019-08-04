module Main where

import Lib
import qualified Server as S

main :: IO ()
main = do 
    S.runApp
