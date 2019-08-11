module Optimizer.Extractor.Selections where

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L

{- As far as I can tell, the granularity of selections can be at any level ranging from one table, to all tables in the query.
Consequently, it initially doesn't make sense to pair selections directly with table info. It *does* make sense to project 
immediately, since an analysis can be done from the very beginning to learn what columns are needed from a given table for the 
rest of the query. Certainly you should push selections down when possible, but that can be done during construction of the
query plan, rather than immediately.


-}

type SelectionStream = [ SelectionInfo ]
type SelectionInfo = SelectionInfo
    {

    }
type Source 

extract :: P.Where 