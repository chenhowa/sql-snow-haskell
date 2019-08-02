module CodeGen.QueryPlan where

import qualified Text.StringTemplate as T
import qualified Data.List as L

data QueryPlan 
    = Read Table 
    | Join QueryPlan QueryPlan [Condition]
    | Projection QueryPlan [(Column, Column)]
    | Selection QueryPlan [ Condition ]
    | Sort QueryPlan Direction Column
    deriving (Eq, Show)

data Direction 
    = Ascending 
    | Descending 
    deriving (Eq, Show)

type Table = String
type Statement = String
type Condition = String 
type Template = T.StringTemplate String
type Column = String

generate :: QueryPlan -> Statement
generate plan = 
    let template = "var gr$table$ = new GlideRecord(\'$table$\');" 
        
    in  case plan of 
            Read table -> generateRead table
            Projection p columns -> 
                generateProjection columns ("source", generate p)
            Selection p conditions -> 
                generateSelection conditions ("source", generate p)
            Sort p dir column -> 
                generateSort column dir ("source", generate p)
            Join p1 p2 conditions -> 
                generateJoin conditions [("source_1", generate p1), ("source_2", generate p2)]

readTemplate :: Template
readTemplate = 
    T.newSTMP $ concat . L.intersperse "\n" $
            [   "{" 
            ,       "init: function init(params){" 
            ,           "this.params = params;" 
            ,           "this.gr = new GlideRecord(\'$table$\');"
            ,           "if(this.params.sorts){"
            ,               "for(var i = 0; i < this.params.sorts.length; i++){"
            ,                   "var sort = this.params.sorts[i];"
            ,                   "if(sort.desc){"
            ,                       "this.gr.orderByDesc(\'sort.column\');"
            ,                   "} else {"
            ,                       "this.gr.orderBy(\'sort.column\');"
            ,                   "}"
            ,               "}"
            ,           "}"
            ,       "}," 
            ,       "next: function next(){" 
            ,           "return this.gr.next();" 
            ,       "}," 
            ,   "}"
            ]


generateRead :: Table -> Statement
generateRead table = 
    T.toString $  T.setManyAttrib [("table", table)] readTemplate 

projectionTemplate :: Template 
projectionTemplate =
    T.newSTMP $ concat . L.intersperse "\n" $
        [   "{"
        ,       "init: function init(params) {"
        ,           "this.params = params"
        ,           "this.source.init(params)"
        ,       "},"
        ,       "next: function next(){" 
        ,           "return this.restricted(this.source.next());"
        ,       "}," 
        ,       "source: $source$,"
        ,       "restricted: $restrictions$,"
        ,   "}" 
        ]

restrictionTemplate :: Template 
restrictionTemplate = 
    T.newSTMP $ concat . L.intersperse "\n" $
        [   "function restriction(tuple){"
        ,       "var item = {"
        ,           "getValue: function(col){"
        ,               "if(this.values[col]){"
        ,                   "return this.values[col];"
        ,               "} else {"
        ,                   "return null;"
        ,               "}"
        ,           "},"
        ,           "values: {"
        ,               "$columns$"
        ,           "},"
        ,       "};"
        ,       "return item;"
        ,   "}"
        ]

generateProjection :: [ (Column, Column) ] -> (String, String) -> Statement 
generateProjection cols source =
    T.toString $  T.setManyAttrib [source, restriction] projectionTemplate
    where 
        restriction = 
            ("restrictions"
            , T.toString $ T.setManyAttrib 
                [("columns", concat . L.intersperse "\n" $ (colText <$> cols))] restrictionTemplate
            )
        colText :: (Column, Column) -> String
        colText (new, old) = 
            let template = T.newSTMP "$new$: tuple.getValue(\'$old$\'),"
            in  T.toString $ T.setManyAttrib [("new", new), ("old", old)] template


selectionTemplate :: Template
selectionTemplate = 
    T.newSTMP $ concat . L.intersperse "\n" $
        [ " {"
        , "     init: function(params) {"
        , "         this.params = params"
        , "         this.params.selections = []"
        , "         this.source.init(this.params)"
        , "     },"
        , "     next: function(){"
        , "         while(this.source.next()){"
        , "             if(this.meetsCondition(this.source)){"
        , "                 return this.source;"
        , "             }"
        , "         }"
        , "         return false;"
        , "     },"
        , "     source: $source$,"
        , "     meetsCondition: function(src){"
        , "         return $condition$(src)"
        , "     },"
        , " }"
        ]

generateSelection :: [ Condition ] -> (String, String) -> Statement
generateSelection conds source = 
    T.toString $ T.setManyAttrib [source] selectionTemplate

sortTemplate :: Template 
sortTemplate = 
    T.newSTMP $ concat . L.intersperse "\n" $
        [   "{"
        ,       "init: function(params) {"
        ,           "this.params = params"
        ,           "var sort = { desc: $desc$, column: $column$ };"
        ,           "if(this.params.sorts) {"
        ,               "this.params.sorts.push(sort);"
        ,           "} else {"
        ,               "this.params.sorts = [sort]"
        ,           "}"
        ,           "this.source.init(this.params)"
        ,       "},"
        ,       "next: function(){"
        ,           "return this.source.next()"
        ,       "},"
        ,       "source: $source$,"
        ,   "}"
        ]

generateSort :: Column -> Direction -> (String, String) -> Statement
generateSort col dir source = 
    T.toString $ T.setManyAttrib [source, desc, column] sortTemplate
    where 
        desc = ("desc", if dir == Ascending then "false" else "true")
        column = ("column", col)

joinTemplate :: Template
joinTemplate = 
    T.newSTMP $ concat
        [   "{"
        ,       "init: function(params) {"
        ,           "this.params = params"
        ,           "this.source_1.init(this.params)"
        ,           "this.source_2.init(this.params)"
        ,       "},"
        ,       "next: function() { /*This uses naive nested loops join. Next will be to use chunk nested loops join*/"
        ,           "while(this.source_1.next()){"
        ,               "var valid_2 = this.source_2.hasNext()"
        ,               "if(!valid_2){"
        ,                   "this.source_2.init(this.params) /*redo the query for the next round*/"
        ,               "}"
        ,               "while(this.source_2.next()){"
        ,                   "if(this.meetsCondition(this.source_1, this.source_2)){"
        ,                       "return this.wrap(this.source_1, this.source_2);"
        ,                   "}"
        ,               "}"
        ,           "}"
        ,           "return false;"
        ,       "},"
        ,       "source_1: $source_1$,"
        ,       "source_2: $source_2$,"
        ,       "meetsCondition: function(src_1, src_2){"
        ,           "return $condition$(src_1, src_2);"
        ,       "},"
        ,       "wrap: function(src_1, src_2){"
        ,           "var item = {"
        ,               "getValue: function(col){"
        ,                   "var val_1 = this.src_1.getValue(col);"
        ,                   "var val_2 = this.src_2.getValue(col);"
        ,                   "if(val_1 !== null && val_2 !== null){"
        ,                       "return [].concat.apply([], [val_1, val_2]);"
        ,                   "} else {"
        ,                       "return val_1 || val_2"
        ,                   "}"
        ,               "}"
        ,           "};"
        ,           "return item;"
        ,       "}"
        ,   "}"
        ]

generateJoin :: [Condition] -> [(String, String)] -> Statement
generateJoin conds srcs =
    T.toString $ T.setManyAttrib srcs joinTemplate

{-

type Cost = Int 

data PlanCost = PlanCost 
    { tables: [ Table ]
    , orderColumns: Columns
    , bestPlan: QueryPlan
    , cost: Cost
    }

estimateCost :: Query -> 

{- 
* number of tuples in a table.
* number of disk pages in a table
* min/max value of each value in a column (High(col), Low(col))
* number of distinct values in a column (NKeys(col))
* height of each index on the table
* number of disk pages in an index

The dynamic programming table will have 4 columns -

* the subset of tables being considered for the row, 
* the interesting order columns (if any for this plan), 
* the best plan, 
* and the cost of this plan. We keep track of interesting order columns so 
    that we can use it later -- it might be cheaper to sort earlier, 
    rather than sort later, for a later operation
-} -}






