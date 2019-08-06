module Optimizer.TableInfo where 

import qualified Parser.Syntax as P
import qualified Data.Map.Strict as Map
import Parser.Validator.Expression (operatorArgs)
import qualified Data.List as L


data TableInfo = 
    Table
        { table :: Table
        , alias :: Alias
        , selection :: P.Expr
        , projection :: [ Column ]
        }
    deriving (Eq, Show)

type Table = String
type Alias = String
type Column = String

extractQueryInfo :: P.Query -> [ TableInfo ]
extractQueryInfo query = case query of 
    P.Select stype mfrom uniq -> case mfrom of 
        Nothing -> []
        Just from -> 
            let finfo = extractFromInfo from
                oinfo = extractOutputInfo stype
    _ -> []

extractFromInfo :: P.FromClause -> [ TableInfo ]
extractFromInfo from = case from of 
    P.FromClause {P.tables=t, P.where_=w, P.groupBy = gb, P.orderBy = ob} ->
        let tables :: [(Table, Alias)]
            tables = extractTables t 

            wColumns :: ColumnInfo
            wColumns = extractColumnsFromWhere w

            gColumns :: ColumnInfo
            gColumns = extractColumnsFromGroupBy gb

            obColumns :: ColumnInfo
            obColumns = extractColumnsFromOrderBy ob

            combinedColumnInfo :: ColumnInfo
            combinedColumnInfo = foldr1 combineColumnInfo [wColumns, gColumns, ob]
        in  (mkTableInfo combinedColumnInfo) <$> tables 

        where 
            mkTableInfo :: ColumnInfo -> (Table, Alias) -> TableInfo
            mkTableInfo info pair = Table
                { table = fst pair
                , alias = snd pair
                , selection = P.Identifier "hi"
                , projection = getProjection info pair
                }
getProjection :: ColumnInfo -> (Table, Alias) -> [Column]
getProjection (m, o) (t, a) = 
    if Map.null m 
    then o 
    else concat 
        [ case Map.lookup t m of 
            Nothing -> []
            Just cols -> cols 
        , if a /= t
          then case  Map.lookup a m of 
                    Nothing -> []
                    Just cols -> cols  
          else []
        , o
        ]

                
extractTables :: [P.Table] -> [(Table, Alias)]
extractTables tables = concat (extractTable <$> tables)
    where 
        extractTable :: P.Table -> [(Table, Alias)]
        extractTable table = case table of 
                P.Table str malias -> 
                    [ (,) str $ case malias of 
                                Nothing -> str
                                Just alias -> alias
                    ]
                P.Natural t1 t2 -> concat [ extractTable t1, extractTable t2 ]
                P.Join _ t1 t2 _ -> concat [ extractTable t1, extractTable t2 ]


type ColumnInfo = (Map.Map Table [Column], [Column])

extractColumnsFromWhere :: Maybe P.Where -> ColumnInfo
extractColumnsFromWhere w = case w of 
    Nothing -> (Map.empty, [])
    Just wh -> extractColumnsFromExpr wh

extractColumnsFromExpr :: P.Expr -> ColumnInfo
extractColumnsFromExpr wh = case wh of 
    P.Identifier id -> case tableAndColumn id of 
        Nothing -> (Map.empty, [id])
        Just (name, col) -> (Map.fromList [(name, [col])], [])
    P.Function _ args -> foldr1 combineColumnInfo (extractColumnsFromExpr <$> args)
    P.Operator op -> 
        foldr1 combineColumnInfo (extractColumnsFromExpr <$> (operatorArgs op))
    _ -> (Map.empty, [])

tableAndColumn :: String -> Maybe (Table, Column)
tableAndColumn str = case L.elemIndex '.' str of 
    Nothing -> Nothing
    Just i -> 
        let split = splitAt i str 
        in Just (fst split, drop 1 $ snd split)

combineColumnInfo :: ColumnInfo -> ColumnInfo -> ColumnInfo 
combineColumnInfo c1 c2 =
    let orphans = concat $ (snd <$> [c1, c2])
        named = Map.unionWith (<>) (fst c1) (fst c2)
    in  (named, orphans)


extractColumnsFromGroupBy :: Maybe P.GroupBy -> ColumnInfo
extractColumnsFromGroupBy mgb = case mgb of 
    Nothing -> (Map.empty, [])
    Just gb -> extractColumns gb 

    where 
        extractColumns :: P.GroupBy -> ColumnInfo
        extractColumns (P.GroupBy ids having) = 
            let havingInfo = extractColumnsFromHaving having
                idInfo = foldr1 combineColumnInfo $ (intoColumnInfo <$> ids)
            in  combineColumnInfo idInfo havingInfo
            where
                intoColumnInfo :: String -> ColumnInfo
                intoColumnInfo str = case tableAndColumn str of 
                    Nothing -> (Map.empty, [str])
                    Just (t, c) -> (Map.fromList [(t, [c])], [])
        extractColumnsFromHaving :: Maybe P.Having -> ColumnInfo 
        extractColumnsFromHaving mhaving = case mhaving of 
            Nothing -> (Map.empty, [])
            Just (P.Having e) -> extractColumnsFromExpr e
                
