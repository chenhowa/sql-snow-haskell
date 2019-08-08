module Optimizer where 
{-
data SortInfo = 
    Sort
        { order :: Int
        , table :: String 
        , column :: String
        , direction :: Direction
        }

data OutputInfo =
    Output
        { order :: Int 
        , columnName :: String
        , expression :: Expression
        }
-}
{- So here's the issue -- when it comes to the output,
does the OutputInfo table's Expression column need to
know what the table is? It might; take for example the following
query: SELECT incident.number, problem.number
FROM incident, problem -}
