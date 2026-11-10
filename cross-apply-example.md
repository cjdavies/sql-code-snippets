`CROSS APPLY` joins each row of the left table to the result of a table expression (a subquery, inline table-valued function, or `STRING_SPLIT`/`OPENJSON`) that can **reference columns from that left row**. A regular `JOIN` can't do that. It behaves like an `INNER JOIN`: left rows are dropped if the right side returns nothing. Use `OUTER APPLY` to keep them, which is the `LEFT JOIN` equivalent.

**Common uses:** top-N per group, calling a table-valued function per row, splitting or shredding strings/JSON, and reusing computed expressions.

**Example: latest 2 orders per customer**

```sql
SELECT c.CustomerID, c.Name, o.OrderID, o.OrderDate, o.Total
FROM dbo.Customers AS c
CROSS APPLY (
    SELECT TOP (2) OrderID, OrderDate, Total
    FROM dbo.Orders AS ord
    WHERE ord.CustomerID = c.CustomerID   -- correlated to the outer row
    ORDER BY ord.OrderDate DESC
) AS o;
```

Customers with no orders don't appear. Switch to `OUTER APPLY` to include them with NULLs.

**Example: split a delimited column**

```sql
SELECT t.TicketID, s.value AS Tag
FROM dbo.Tickets AS t
CROSS APPLY STRING_SPLIT(t.Tags, ',') AS s;
```