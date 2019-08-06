module Optimizer.TableInfo where 

import qualified Parser.Syntax as P


data TableInfo = 
    Table
        { table :: Table
        , alias :: Alias
        , selection :: Expression
        , projection :: [ Column ]
        }

type Table = String
type Alias = String

extractQueryInfo :: P.Query -> [ TableInfo ]
extractQueryInfo query = case query of 
    Select stype mfrom uniq -> case mfrom of 
        Nothing -> []
        Just from -> extractFromInfo from
    _ -> []

extractFromInfo :: P.FromClause -> [ TableInfo ]
extractFromInfo from -> case from of 
    FromClause {tables=t, where_=w, groupBy = gb, orderBy = ob} ->
        let tables = extractTables t 
            wColumns = extractColumnsFromWhere w
            gbColumns = extractColumnsFromGroupBy gb
        in  CONCAT ?? [tables, wColumns, gbColumns]

extractTables :: [P.Table] -> [(Table, Alias)]
extractTables tables = concat (extractTable <$> tables)
    where 
        extractTable :: P.Table -> [(Table, Alias)]
        extractTable table = case table of 
                Table str malias -> 
                    [ (,) str $ case malias of 
                                Nothing -> str
                                Just alias -> alias
                    ]
                Natural t1 t2 -> [ extractTable t1, extractTable t2 ]
                Join _ t1 t2 _ -> [ extractTable t1, extractTable t2 ]

extractColumnsFromWhere :: Maybe P.Where -> (Map.Map Table [Column], [Column])
extractColumnsFromWhere w = case w of 
    Nothing -> (emptyMap, [])
    Just wh -> extractColumns wh

    where 
        extractColumns :: P.Where -> (Map.Map Table [Column], [Column])
        extractColumns wh = case wh of 
            P.Identifier id -> 
            P.Function _ args -> CONCAT?? $ (extractColumns <$> args)
            P.Operator op -> 
                let cols = CONCAT?? $ (extractColumns <$> (getArgs op))
                in cols
            _ -> (emptyMap, [])

extractColumnsFromGroupBy :: Maybe P.GroupBy -> (Map.Map Table [Column], [Column])
extractColumnsFromGroupBy mgb = case mgb of 
    Nothing -> (emptyMap, [])
    Just gb -> extractColumns gb 

    where 
        extractColumns :: P.GroupBy -> (Map.Map Table [Column], [Column])
        extractColumns (GroupBy ids having) = 
            let fromIds = extractColumnsFromIds ids 
                fromHaving = extractColumnsFromHaving having
            in CONCAT ??? [fromIds, fromHaving]

                
