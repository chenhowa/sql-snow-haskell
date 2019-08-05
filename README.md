# sql-snow-haskell

## Generating Query Plans from the AST

One interesting problem that I've run into is what to do with the AST. Assuming the AST is valid, what should be done to turn it into a Query Plan? The reason that this is a problem at all is two-fold. First, Query Plans are structured as left-deep trees, where each node is an individual operator that performs just one operation. That means that a query like "SELECT *table1.col* FROM *table1* INNER JOIN *table2* ON *table1.col* = *table2.col* INNER JOIN *table3* ON *table2.col* = *table3.col* WHERE *table1.col* > 5" is represented very differently as an AST compared to a Query Plan.

As an AST, the clauses are almost linear: the SELECT is followed by a FROM clause full of nested subtree of JOINs, which is followed by a flat subtree of WHERE clauses. But although this compares very favorably to a language-like sentence, the ordering doesn't make sense from a mechanistic standpoint:

1. Choose the columns you want
2. Choose the records from the tables
3. Throw out the records you don't want.

The correct ordering, mechanistically, would be for the FROM to go first, followed by WHERE, and then SELECT -- which corresponds to the following ordered steps:

1. Get the records from the tables
2. Keep only the records that you want
3. From the kept records, keep only the columns you want.

This mismatch between the AST and the actual "mechanistic" steps only gets worse as you add more clauses to the query. In fact, as a Query Plan, the ordering of operators is much more similar to this second version than the first.

This leads to the second problem: even if we have a method to turn the AST into a query plan, how do we turn it into an *acceptable* query plan? Traditionally, this is handled by the Query Optimizer. But what input does the Query Optimizer take? The query optimizer should deeply understand the possibilities -- what tables are being queried, what columns they are being joined on, what conditions the records are being filtered on, and so on. But as we noted above, the AST does not present this information clearly -- each table's query information is spread across the SELECT, FROM, WHERE, GROUP BY, and HAVING clauses, making it difficult to process the entire query in just one or two passes of the AST. Processing the entire query using just the AST would seem to require multiple passes the maintenance of a lot of state, which is poor for both performance and maintainability in Haskell, which dislikes mutable state (as it should). Although the State Monad is useful, writing a giant mutable program is not an appropriate use for it.

The solution to both problems would seem to be converting the AST into a table-based representation before passing it to the query optimizer. The proposed tables with example data are below:

For getting data from tables:

| Table       | Sel             | Proj                     | 
| ---         | ---             | ---                      | 
| inc         | LEN(desc) > 10  | number, category, sys_id |
| inc_task    | state = 5       | description, parent      |
| problem     | state = 2       | reported_by, state, age  |

For joining tables:

| Table 1  | Table 2  | On Condition |
| ---      | ---      | ---          |
| inc      | inc_task | inc.sys_id = inc_task.parent |
| problem  | inc      | problem.reported_by = inc.sys_id |

For the grouping phase, we have the table below. But note that because we can't write to disk, we'd have to implement this by relying on the GlideRecord "sort" functionality. It's unclear right now whether we can group by multiple columns successfully or not. Also, this table may simply be empty

| Table    | Column   |
| ---      | ---      |
| inc      | category | 
| problem  | state    |

We then need a separate phase for filtering the groups. Aggregates on the groups are applied at this stage for filtering

| Expression        |
| ---               |
| COUNT(*) > 5 AND MAX( (problem, age) ) < "5 weeks"  |

Following this is a phase for sorting the data, using the table shown below. Note that in ServiceNow, sorting can only be implemented in certain special circumstances (because out-of-core algorithms for sorting are not available), so I might not implement sorting at all. *ALSO NOTE:* The only fields available for sorting are the fields that will appear in the output! That makes sense, right? __Since the output cannot be sorted by something that isn't in the output.__

| Order | Table   | Column Name  | Direction |
| ---   | ---     | ---          | ---       |
| 1     | inc     | sys_id       | ASC       |
| 2     | problem | reported_by  | DESC      |
 

For final output -- weird sort-of projection, that doesn't have much to do with the query optimizer. The input to the algorithm for this table would probably need to note how the data was grouped, for the aggregate functions to count or find the max correctly.:

| Order |  Column Name  | Expression  |
| ---   |  ---          | ---         |
| 1     |  description  | description |
| 2     |  number       | number      |
| 3     |  state        | state       |
| 4     |  count        | COUNT(*)    |
| 5     |  max          | MAX( (problem, state) )  |
| 6     |  concat       | (inc_task, description) <> " " <> (problem, state) |

### Query Optimizer Algorithm

Here's a pseudo-algorithm for the Query Optimizer to take the above tables and turn them into a Query Plan.

```
while the Query Plan is not complete
    for each table in Tables
        if table has not been used in the query plan
            calculate the cost of adding the table to the query plan
        put the cheapest addition in the query plan build-up table, along with the cost.
        Also add any interesting order plans, along with their costs.

Choose the cheapest complete query plan, and pass it to aggregation for groupinig, and then use the "having" clause to filter the kept groups.

Pass the groups to the final projection/output columns, and then to the Order By for sorting (which we won't allow for SQL-Snow, since we don't have access to indexes or out-of-core algorithms).
```

## Representing Functions and Operators

The second problem that needs addressing is how to translate conditions and operators like "LEN(x) > 5 AND y IS NOT NULL" into code for both the Query Optimizer, the resulting Query Plan, and the code generated from the query plan. At the time of first writing, I only have the code generated from the query plan, where I essentially copy and paste the condition and operators directly into the generated code as a *function call* of the form "*condition*(record)", that calls the *condition* function on the record currently being processed in the code. But although the general idea is good, it isn't immediately clear how an expression like the one above can be translated into a simple function call.

But let's make an attempt, starting from the AST of an expression, which itself is a good representation of how the functions should be generated. An expression is nothing more than a nested series of expressions, and expressions can take any of the following forms:

* An identifier, representing some table column
* A constant, like a number, string, or boolean
* A function call with nested expression arguments, like "COUNT(id)" or "CONCAT(id, first_name)
* An operator with nested expression arguments, like "active = 'True' AND state = 5"
* A subquery, like "id in (SELECT sid FROM students)"

Since expressions are recursive, our goal is to develop a recursive method for generating a function that correctly applies the expression to whatever tuple, or set of tuples, it receives. We might try the following:

* identifier - function of no arguments that returns the string form of the identifier.
* constant - function of no arguments that just returns the constant, whether is a number or boolean
* function call - function that calls he named function with the arguments
* operator - function that calls the named function with the arguments
* subquery - function that returns an iterator that returns rows of the results, projected down to the correct columns.
  * This would be useful for the IN operator, which takes a one-valued expression as the first argument, and a subquery as the second argument. The implementation would take the one value, and iterate through the subquery iterator, checking to see if the value is present.

Based on the above discussion, there seems to be a case for a function on a tuple called "getColumn(index: number)", just in case the parse tree fails to rule out a subquery that returns more than one column -- we could just take the first column no matter how many columns are returned.

### Dynamic vs Static Typing

For both function calls and operators, the types of the arguments can be important during code execution. What does it mean to calculate the length of a number? Or determine whether a value is IN a string? In such cases, we have two options: static type checking or dynamic type checking. Static type checking will occur during the parsing phase, and is intended to prevent the above situations. Dynamic type checking will occur during runtime, and decide what to do based on the received types. For now, we will use dynamic type checking, since it is easier to implement: if the type is not the correct type, simply return NULL. NULL values will propagate up through the expression, and the entire expression will ultimate have a value of NULL.



