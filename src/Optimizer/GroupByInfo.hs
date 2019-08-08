module Optimizer.GroupByInfo where

import qualified Parser.Syntax as P

data GroupInfo = 
    Group
        { table :: String
        , column :: String
        }

type Having = Expression