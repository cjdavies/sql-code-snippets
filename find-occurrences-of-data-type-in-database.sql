/* Find occurrences of a data type in a database */
SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName
FROM sys.schemas s
JOIN sys.tables t 
    ON t.schema_id = s.schema_id
JOIN sys.columns c 
    ON c.object_id = t.object_id
WHERE c.system_type_id = 104   -- 104 = BIT datatype
ORDER BY 
    s.name, 
    t.name, 
    c.name;


/* List of data types
SELECT system_type_id, name AS datatype
FROM sys.types
WHERE system_type_id = user_type_id
ORDER BY system_type_id;

system_type_id	datatype
34	image
35	text
36	uniqueidentifier
40	date
41	time
42	datetime2
43	datetimeoffset
48	tinyint
52	smallint
56	int
58	smalldatetime
59	real
60	money
61	datetime
62	float
98	sql_variant
99	ntext
104	bit
106	decimal
108	numeric
122	smallmoney
127	bigint
165	varbinary
167	varchar
173	binary
175	char
189	timestamp
231	nvarchar
239	nchar
241	xml
*/