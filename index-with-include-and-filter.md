Here’s a **complete SQL Server 2019 example** showing how to create a
**nonclustered index** with **included columns** and a **filter** to
optimize a query.

**Example Scenario**

We have a Sales table, and we often query **only completed orders**
(Status = 'Completed') but need extra columns in the result without
making them part of the index key.

**1. Create Sample Table and Data**

**Sql**

-- Create sample table

CREATE TABLE Sales (

SaleID INT IDENTITY PRIMARY KEY,

CustomerID INT NOT NULL,

OrderDate DATE NOT NULL,

Status VARCHAR(20) NOT NULL,

TotalAmount DECIMAL(10,2) NOT NULL,

Notes NVARCHAR(200) NULL

);

-- Insert sample data

INSERT INTO Sales (CustomerID, OrderDate, Status, TotalAmount, Notes)

VALUES

(1, '2024-01-10', 'Completed', 150.00, 'First order'),

(2, '2024-01-12', 'Pending', 200.00, 'Awaiting payment'),

(3, '2024-01-15', 'Completed', 300.00, 'Repeat customer'),

(4, '2024-01-20', 'Cancelled', 100.00, 'Customer request'),

(5, '2024-01-22', 'Completed', 250.00, 'Urgent delivery');

**2. Create a Filtered Index with Included Columns**

**Sql**

-- Create a nonclustered index on OrderDate for completed orders

-- Include TotalAmount and Notes so they are available without extra
lookups

CREATE NONCLUSTERED INDEX IX\_Sales\_CompletedOrders

ON Sales (OrderDate)

INCLUDE (TotalAmount, Notes)

WHERE Status = 'Completed';

**Explanation:**

-   **Key column**: OrderDate — used for filtering/sorting in queries.

-   **Included columns**: TotalAmount, Notes — stored in the index leaf
    level for quick retrieval.

-   **Filter**: WHERE Status = 'Completed' — reduces index size and
    improves performance for targeted queries.

**3. Query That Uses the Index**

**Sql**

-- This query will benefit from the filtered index

SELECT OrderDate, TotalAmount, Notes

FROM Sales

WHERE Status = 'Completed'

AND OrderDate &gt;= '2024-01-01'

ORDER BY OrderDate;

**4. Why This Helps**

-   **Smaller index**: Only rows with Status = 'Completed' are stored.

-   **Fewer lookups**: Included columns mean SQL Server doesn’t need to
    go back to the base table for TotalAmount and Notes.

-   **Faster reads**: Especially useful when the filtered condition
    matches a large percentage of queries.
