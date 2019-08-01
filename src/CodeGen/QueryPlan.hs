module CodeGen.QueryPlan where

import qualified Text.StringTemplate as T

data QueryPlan 
    = Read Table 
    | Join QueryPlan QueryPlan [Condition]
    | Projection QueryPlan [Column]
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
    T.newSTMP $ concat 
            [   "{" 
            ,       "init: function(params){" 
            ,           "this.params = params" 
            ,           "this.gr = new GlideRecord(\'$table$\');" 
            ,       "}, " 
            ,       "next: function(){" 
            ,           "return gr.next()" 
            ,       "}" 
            ,   "}"
            ]


generateRead :: Table -> Statement
generateRead table = 
    T.toString $  T.setManyAttrib [("table", table)] readTemplate 

projectionTemplate :: Template 
projectionTemplate =
    T.newSTMP $ concat
        [   "{"
        ,       "init: function(params) {"
        ,           "this.params = params"
        ,           "this.source.init()"
        ,       "},"
        ,       "next: function(){" 
        ,           "return this.source.next()" 
        ,       "}," 
        ,       "source: $source$," 
        ,   "}" 
        ]


generateProjection :: [ Column ] -> (String, String) -> Statement 
generateProjection cols source =
    T.toString $  T.setManyAttrib [source] projectionTemplate

selectionTemplate :: Template
selectionTemplate = 
    T.newSTMP $ concat 
        [   "{"
        ,       "init: function(params) {"
        ,           "this.params = params"
        ,           "this.source.init()"
        ,       "}"
        ,       "next: function(){"
        ,           "return this.source.next()"
        ,       "},"
        ,       "source: $source$,"
        ,   "}"
        ]

generateSelection :: [ Condition ] -> (String, String) -> Statement
generateSelection conds source = 
    T.toString $ T.setManyAttrib [source] selectionTemplate

sortTemplate :: Template 
sortTemplate = 
    T.newSTMP $ concat 
        [   "{"
        ,       "init: function(params) {"
        ,           "this.params = params"
        ,           "this.source.init()"
        ,       "}"
        ,       "next: function(){"
        ,           "return this.source.next()"
        ,       "},"
        ,       "source: $source$,"
        ,   "}"
        ]

generateSort :: Column -> Direction -> (String, String) -> Statement
generateSort col dir source = 
    T.toString $ T.setManyAttrib [source] sortTemplate

joinTemplate :: Template
joinTemplate = 
    T.newSTMP $ concat
        [   "{"
        ,       "init: function(params) {"
        ,           "this.params = params"
        ,           "this.source_1.init()"
        ,           "this.source_2.init()"
        ,       "},"
        ,       "next: function() {"
        ,       "},"
        ,       "source_1: $source_1$,"
        ,       "source_2: $source_2$,"
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






