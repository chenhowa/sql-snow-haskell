module Optimizer.JoinInfo where 

import Prelude
import qualified Parser.Syntax as P

data JoinInfo = 
    Join
        { table1 :: String
        , table2 :: String
        , onCondition :: JoinCondition
        }

extractQueryInfo :: P.Query -> [JoinInfo]
extractQueryInfo q = case q of 
    P.Select _ mfrom _ ->  case mfrom of 
        Nothing -> []
        Just from -> extractFromInfo from
    _ -> []

extractFromInfo :: P.FromClause -> [JoinInfo]
extractFromInfo (P.FromClause ts ws _ _ _) = 
    let tInfo = extractTableInfo ts
        wInfo = extractWhereInfo ws
    in  CONCAT ?? [ tinfo wInfo ]