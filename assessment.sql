-- 1. Write a query to add the following columns to the Staff table

--            First Name

--            Last Name

--            Email
INSERT INTO [Column] 
	(
		[TableID], 
		[SystemName], 
		[DisplayName], 
		[DisplayOrder]
	)
SELECT 
	[TableID], 
	'First Name', 
	'V001', 
	1 
FROM 
	[Table] 
WHERE 
	TableName = 'Staff';
----------------------------------
----------------------------------
INSERT INTO [Column] 		
	(
		[TableID], 
		[SystemName], 
		[DisplayName], 
		[DisplayOrder]
	)
SELECT 
	[TableID], 
	'Last Name', 
	'V002', 
	2 
FROM 
	[Table] 
WHERE 
	TableName = 'Staff';
----------------------------------
----------------------------------
INSERT INTO [Column] 
	(
		[TableID], 
		[SystemName], 
		[DisplayName], 
		[DisplayOrder]
	)
SELECT 
	[TableID], 
	'Email', 
	'V003', 
	3 
FROM 
	[Table] 
WHERE 
	TableName = 'Staff';

-- 2. Write a query to add 2 people to the Staff table

--            John Smith <john.smith@gmail.com>

--            Roger Brown <roger_brown@yahoo.com.au>

INSERT INTO [Record]
	(
		[TableID],
		[V001],
		[V002],
		[V003]
	)
SELECT
	[TableID],
	'John',
	'Smith',
	'john.smith@gmail.com'
FROM
	[Table]
WHERE
	TableName = 'Staff';
----------------------------------
----------------------------------
INSERT INTO [Record]
	(
		[TableID],
		[V001],
		[V002],
		[V003]
	)
SELECT
	[TableID],
	'Roger',
	'Brown',
	'roger_brown@yahoo.com.au'
FROM
	[Table]
WHERE
	TableName = 'Staff';

-- 3. Write a query to add a column that allows us to associate Staff with Company

--            Note: We always link on RecordID

INSERT INTO [Column] 
	(
		[TableID], 
		[SystemName], 
		[DisplayName], 
		[DisplayOrder]
	)
SELECT 
	[TableID], 
	'RecordID', 
	'V004', 
	4 
FROM 
	[Table] 
WHERE 
	TableName = 'Staff';
----------------------------------
----------------------------------
INSERT INTO [Column] 
	(
		[TableID], 
		[SystemName], 
		[DisplayName], 
		[DisplayOrder]
	)
SELECT 
	[TableID], 
	'RecordID', 
	'V004', 
	4 
FROM 
	[Table] 
WHERE 
	TableName = 'Company';

-- 4. Link the 2 new people from question 2 to the company Darnit

UPDATE 
	Record 
SET 
	V004 = (
		SELECT 
			RecordID 
		FROM 
			[Record] 
		WHERE 
			V001 = 'Darnit'
	) 
WHERE 
	V003 = 'john.smith@gmail.com' 
OR
	V003 = 'roger_brown@yahoo.com.au';

-- 5. Write a query to display the staff and company data in a readable format

WITH staff (FirstName, LastName, Email, RecordID) AS (
	SELECT
		staff.v001 as FirstName,
		staff.v002 as LastName,
		staff.v003 as Email,
		staff.v004 as RecordID
	FROM
		[Record] staff
	WHERE
		staff.TableID = (
					SELECT 
						TableID 
					FROM 
						[Table] 
					WHERE 
						TableName = 'Staff'
				)
), company (CompanyName, Address, PhoneNumber, RecordID) AS (
	SELECT
		company.v001 as CompanyName,
		company.v002 as Address,
		company.v003 as PhoneNumber,
		company.RecordID as RecordID
	FROM
		[Record] company
	WHERE
		company.TableID = (
					SELECT 
						TableID 
					FROM 
						[Table] 
					WHERE 
						TableName = 'Company'
				)
)
SELECT
	c.CompanyName,
	c.Address,
	s.FirstName,
	s.LastName,
	s.Email,
	c.PhoneNumber
FROM
	company c
INNER JOIN
	staff s
ON
	s.RecordID = c.RecordID