In SQL Server, IDENTITY columns and SEQUENCE objects both generate numeric values, but they serve different purposes. In general:

Use IDENTITY when a value only belongs to a single table and is primarily used as a surrogate primary key.
Use SEQUENCE when you need more flexibility, sharing, or control over number generation.
Identity Column

Example:

CREATE TABLE dbo.Customer
(
    customer_id INT IDENTITY(1,1) NOT NULL,
    customer_name NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Customer
        PRIMARY KEY CLUSTERED (customer_id)
);

Pros
1. Simpler to implement

The identity value is tied directly to the table.

INSERT INTO dbo.Customer (customer_name)
VALUES ('Acme');

SELECT SCOPE_IDENTITY();


No separate object needs to be maintained.

2. Good fit for primary keys

For most OLTP systems, an identity column is all that's needed for surrogate keys.

3. Less chance of misuse

Developers cannot accidentally consume identity values without inserting rows.

4. Common and familiar

Most SQL Server developers expect table primary keys to use identity columns.

Cons
1. Cannot be shared across tables

Each table has its own identity generator.

For example:

Customer.customer_id
Order.order_id


cannot be generated from the same numbering stream.

2. Limited control

You cannot:

Generate a value before inserting
Reserve blocks of numbers
Use multiple numbering schemes easily
3. Gaps occur

Rollback does not restore consumed identity values.

BEGIN TRAN;

INSERT INTO dbo.Customer (customer_name)
VALUES ('Test');

ROLLBACK;


The identity value is lost.

4. Harder to restart or manipulate

Changing identity values often requires:

DBCC CHECKIDENT


which is less flexible than altering a sequence.

Sequence Object

Example:

CREATE SEQUENCE dbo.CustomerSequence
AS INT
START WITH 1
INCREMENT BY 1;


Usage:

INSERT INTO dbo.Customer
(
    customer_id,
    customer_name
)
VALUES
(
    NEXT VALUE FOR dbo.CustomerSequence,
    'Acme'
);

Pros
1. Can be shared across multiple tables

A sequence is an independent database object.

Customer
Order
Invoice


can all draw values from the same sequence.

Example:

NEXT VALUE FOR dbo.GlobalSequence


This is one of the biggest advantages.

2. Can obtain numbers before inserts

You can generate values without inserting a row.

DECLARE @id INT;

SET @id = NEXT VALUE FOR dbo.CustomerSequence;


Useful when:

Building parent/child records
Generating batch numbers
Creating reference numbers
3. Supports range allocation

You can allocate blocks of numbers.

sp_sequence_get_range


This is useful for:

ETL processes
Distributed systems
High-volume imports
4. More flexible numbering

You can define:

START WITH 100000
INCREMENT BY 10
MINVALUE 100000
MAXVALUE 999999
CYCLE
CACHE 100


Identity columns have much less configurability.

5. Better for enterprise numbering schemes

Examples:

Invoice numbers
Claim numbers
Ticket numbers
Global document IDs

where multiple tables or applications need a single sequence.

Cons
1. More objects to manage

You must create and maintain the sequence separately.

CREATE SEQUENCE dbo.InvoiceSequence;


This adds administrative overhead.

2. Easier to waste numbers

A value is consumed as soon as:

NEXT VALUE FOR


is executed.

Even if no insert occurs, the number is gone.

DECLARE @id INT =
    NEXT VALUE FOR dbo.InvoiceSequence;

-- never inserted


Number is lost.

3. Gaps are even more common

Sequence values are not transactional.

If a transaction rolls back, the sequence still advances.

Additionally, cached values can be lost during unexpected shutdowns.

4. Requires explicit coding

Every insert must request the next value.

INSERT INTO dbo.Customer
(
    customer_id,
    customer_name
)
VALUES
(
    NEXT VALUE FOR dbo.CustomerSequence,
    'Acme'
);


Identity columns generate automatically.

Performance Considerations

For most applications:

Performance differences are negligible.
Both are highly optimized.
Both can produce gaps.
Both support caching internally.

For extremely high-throughput systems, sequences can sometimes scale better because they are designed as standalone generators and support cached ranges efficiently.

My Rule of Thumb

As a database architect, I generally recommend:

Use IDENTITY when
The value belongs to one table.
It is a surrogate primary key.
Simplicity is preferred.

Example:

[Customer].[customer_id]
[Order].[order_id]
[Product].[product_id]

Use SEQUENCE when
Multiple tables share a numbering scheme.
Values must be generated before inserts.
Blocks of numbers must be allocated.
Business numbering requirements exist.

Example:

InvoiceNumber
ClaimNumber
DocumentNumber
BatchNumber


For most SQL Server OLTP tables that follow your preferred pattern of INT IDENTITY(1,1) surrogate keys, IDENTITY remains the best default choice, while SEQUENCE is the better tool for business-generated numbers and cross-table numbering requirements.

When migrating data between databases, IDENTITY columns are generally easier to move, while SEQUENCE objects require more planning. The implications depend on whether you're preserving existing keys or generating new ones in the target system.

Identity Columns
Scenario 1: Preserving Existing Values

Suppose the source contains:

customer_id
-----------
1
2
3


You can insert the values explicitly:

SET IDENTITY_INSERT dbo.Customer ON;

INSERT INTO dbo.Customer
(
    customer_id,
    customer_name
)
SELECT
    customer_id,
    customer_name
FROM SourceDB.dbo.Customer;

SET IDENTITY_INSERT dbo.Customer OFF;


Afterward, you should reseed the identity:

DBCC CHECKIDENT ('dbo.Customer', RESEED);

Benefits
Straightforward migration process.
Keys can be preserved exactly.
Foreign key relationships remain intact.
Risks
Forgetting to reseed can cause duplicate key errors later.
Only one table per session can have IDENTITY_INSERT ON.
Large migration scripts become more cumbersome.
Sequence Objects
Scenario 1: Preserving Existing Values

If the target table is populated with explicit values:

INSERT INTO dbo.Customer
(
    customer_id,
    customer_name
)
SELECT
    customer_id,
    customer_name
FROM SourceDB.dbo.Customer;


The sequence does not automatically adjust.

For example:

CREATE SEQUENCE dbo.CustomerSequence
    START WITH 1;


After loading IDs up to 500, the sequence may still be returning:

NEXT VALUE FOR dbo.CustomerSequence


= 1

which causes duplicate key violations.

You must manually advance it:

ALTER SEQUENCE dbo.CustomerSequence
RESTART WITH 501;

Cutover Challenges
Identity

To determine the next value:

SELECT IDENT_CURRENT('dbo.Customer');


or

DBCC CHECKIDENT ('dbo.Customer');


SQL Server manages the next identity internally.

Sequence

You must validate both:

Maximum key in the table
Current sequence value

Example:

SELECT MAX(customer_id)
FROM dbo.Customer;


and compare that to:

SELECT current_value
FROM sys.sequences
WHERE name = 'CustomerSequence';


A mismatch can create failures immediately after go-live.

Multiple Tables Sharing a Sequence

This is where migrations become more complex.

Consider:

Customer
Order
Invoice


all using:

dbo.GlobalSequence


You cannot simply examine a single table to determine the restart value.

You must determine the highest value consumed across all participating tables.

Example:

SELECT MAX(id_value)
FROM
(
    SELECT MAX(customer_id) AS id_value FROM dbo.Customer
    UNION ALL
    SELECT MAX(order_id) FROM dbo.[Order]
    UNION ALL
    SELECT MAX(invoice_id) FROM dbo.Invoice
) x;


Then restart:

ALTER SEQUENCE dbo.GlobalSequence
RESTART WITH <MaxValue + 1>;


This is one of the biggest migration disadvantages of shared sequences.

ETL and Incremental Loads
Identity

Many ETL tools handle identities naturally:

SSIS
Azure Data Factory
SQL Data Migration Assistant
BCP

The only special handling is usually IDENTITY_INSERT.

Sequence

You must migrate:

The table data
The sequence object
The sequence state

Missing step 3 often produces production issues.

Database Restore vs Data Migration

There's a major distinction.

Full Backup/Restore

When you restore a database:

RESTORE DATABASE ...


both identities and sequences come across intact.

No special handling is needed.

Data-Only Migration

Examples:

SSIS package
BCP export/import
Data Factory copy
Custom ETL

In this case:

Identity values move with the data.
Sequence definitions may move.
Sequence current position may not.

This is where most problems occur.

Replication and Distributed Systems

Sequences often shine here.

For example:

sp_sequence_get_range


can allocate:

Server A: 1 - 100000
Server B: 100001 - 200000
Server C: 200001 - 300000


This makes merging data from multiple sources easier.

Doing the same thing with identity columns typically requires:

IDENTITY(1,3)
IDENTITY(2,3)
IDENTITY(3,3)


or identity range management, which is more complicated.

In distributed migration scenarios, sequences are frequently superior.

What I See Most Often

For surrogate primary keys:

customer_id INT IDENTITY(1,1)
order_id INT IDENTITY(1,1)


migration is usually simpler because:

The current value is tied to the table.
Reseeding is straightforward.
There is no separate object to synchronize.

For business numbering systems:

InvoiceNumber
ClaimNumber
BatchNumber


a sequence is usually better despite the extra migration work because the numbering logic is centralized and independent of any one table.

Practical Recommendation

For the style of SQL Server schema you typically use (surrogate INT IDENTITY(1,1) primary keys):

Database backup/restore: No significant difference.
Data-only migration: Identity columns are generally easier to migrate.
Cross-database synchronization: Identity columns are easier to maintain.
Multi-table numbering schemes: Sequences are better, but you must remember to migrate and reseed the sequence itself.
Distributed or multi-writer systems: Sequences often provide more flexibility.

A common post-migration validation step I use is:

SELECT
    MAX(customer_id) + 1 AS expected_next_value
FROM dbo.Customer;


and then verify that the identity seed or sequence restart value is at least that number before opening the system to users. This catches most migration-related key generation issues before they become production outages.
