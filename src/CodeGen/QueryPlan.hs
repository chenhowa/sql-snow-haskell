module CodeGen.QueryPlan where

{- data QueryPlan 
    = Join QueryPlan QueryPlan 
    | Read Table 
    | Projection QueryPlan Columns
    | Selection QueryPlan Conditions
    | Sort QueryPlan Direction Columns 
    deriving (Eq, Show)

data Direction 
    = Ascending 
    | Descending 
    deriving (Eq, Show)

type Table = String
type Columns = [ String ]
type Conditions = [ String ]
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






