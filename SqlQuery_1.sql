-- Create a new database named Example
Create database Example

-- Switch to the Example database
use Example







-- 1NF - Atomic Value or 1 cell 1 value
-- The following steps demonstrate how to create tables and add constraints while ensuring the data adheres to the First Normal Form.






-- Create a table named 'product' without constraints
Create table product(
    ProductID INT,            -- Column for ProductID of type INT
    Productname VArchar(50),   -- Column for Productname of type VARCHAR(50)
    Usage Varchar(50),        -- Column for Usage of type VARCHAR(50)
    Manufacture Varchar(50),  -- Column for Manufacture of type VARCHAR(50)
    Price Money,              -- Column for Price of type MONEY
    Description Varchar(50),  -- Column for Description of type VARCHAR(50)
    NoofStock int             -- Column for NoofStock of type INT
)



-- Alter the Product table to ensure the ProductID column is NOT NULL
Alter table product
Alter column ProductID int not null; -- Alters ProductID to be non-nullable

-- Add a primary key constraint on the ProductID column and name the constraint PK_ProductID
Alter table product
Add constraint PK_ProductID Primary key(ProductID);  -- Adds a primary key constraint on ProductID

-- View the properties of the 'product' table (such as columns, types, constraints, etc.)
EXEC SP_HELP product;

-- Insert a row of values into the 'product' table
insert into product(ProductID, Productname, Usage, Manufacture, Price, Description, NoofStock)
values (1, 'Nike Air Max', 'Casual', 'Nike', 125, 'A Casual shoe for everyday wear', 15);

-- View the inserted values in the product table
Select * from product;  -- Displays all the rows in the 'product' table

alter table product drop column Usage;--Drop the table column Usage
alter table product drop column Manufacture;--Drop the table column Manufacture







-- Create a new table named 'Category' with a CategoryID as an Identity column (auto-incremented)
Create table Category(
    Category int Identity(1,1) ,  -- CategoryID auto-increments starting from 1, and is set as the primary key
    CatergoryName VARCHAR(20) NOT NULL          -- CategoryName column of type VARCHAR(20) which cannot be null
);
Alter table Category
Add constraint PK_CategoryID Primary key(Category)
-- Allow manual insertion of values into the Category table even though CategoryID is an Identity column
SET Identity_insert Category On; -- Allows inserting into the Identity column

-- Insert a row into the 'Category' table with explicit CategoryID (10) and CatergoryName ('Men')
Insert into Category(Category, CatergoryName)
select 10, 'Men';  -- Inserts the category 'Men' with CategoryID 10

-- Turn off the Identity Insert setting
SET Identity_insert Category Off;  -- Disables manual insertion of Identity column values

-- Insert a row into the 'Category' table, letting the Identity column auto-generate
Insert into Category(CatergoryName)
select 'Women';  -- Inserts the category 'Women' with auto-generated CategoryID

-- View the values in the 'Category' table
Select * from Category;  -- Displays all rows in the 'Category' table









-- Create a table named 'Color'
Create table Color(
    ColorID Char(6) Primary key,  -- ColorID column is of type CHAR(6), with a fixed length of 6 characters, and is set as the primary key
    ColorName VARCHAR(20) NOT NULL  -- ColorName column is of type VARCHAR(20), allowing up to 20 characters, and it cannot be NULL
);

-- Insert multiple rows into the 'Color' table using the UNION operator to combine multiple SELECT statements
insert into Color(ColorID, ColorName) 
select 'clr001', 'Black'  -- Insert a row with ColorID 'clr001' and ColorName 'Black'
union
select 'clr002', 'White'  -- Insert a row with ColorID 'clr002' and ColorName 'White'
union
select 'clr003', 'Green'; -- Insert a row with ColorID 'clr003' and ColorName 'Green'

-- Select all rows from the 'Color' table to view the inserted data
select * from Color;  -- Displays all rows in the 'Color' table












-- Create a table named 'Size' with two columns: SizeID and SizeDescription
Create table Size(
    SizeID int,                     -- Column for SizeID of type INT (this will store unique size identifiers)
    SizeDescription Varchar(50),     -- Column for SizeDescription of type VARCHAR(50) to store size descriptions (e.g., 'US Men's 9')
    Constraint PK_SIZE Primary Key(SizeID)  -- Add a primary key constraint on the SizeID column, ensuring uniqueness and non-nullability
);

-- Insert multiple values into the 'Size' table

Insert into Size(SizeID, SizeDescription)
select 1, 'US Mens 9'   -- Insert SizeID 1 with description 'US Men's 9'
union
select 2, 'EU Womens 37'  -- Insert SizeID 2 with description 'EU Women's 37'
union
select 3, 'UK Mens 8';    -- Insert SizeID 3 with description 'UK Men's 8'

-- Select all rows from the 'Size' table to view the inserted data
Select * from Size;  -- Displays all the rows in the 'Size' table (SizeID and SizeDescription)



select * from product;
select * from Size;
select * from Category;
Select * from Color;





-- 2NF: Ensure the table is in First Normal Form (1NF) and then apply the rule of full dependency.
-- First, create the Usage table:

Create table Usage(
    UsageID Char(5),                   -- UsageID column of type CHAR(5) to store unique usage identifiers (e.g., 'U001', 'U002')
    UsageDescription Varchar(50),       -- UsageDescription column of type VARCHAR(50) to store the description of the usage type (e.g., 'Casual', 'Running')
    Constraint PK_UsageID Primary Key(UsageID)  -- Define UsageID as the primary key, ensuring uniqueness and non-nullability
);

-- Insert values into the Usage table:
insert into Usage(UsageID, UsageDescription)
values
('U001', 'Casual'),                  -- Insert UsageID 'U001' with description 'Casual'
('U002', 'Running');                  -- Insert UsageID 'U002' with description 'Running'

-- Display the data from the Usage table:
Select * from Usage;  -- Retrieves all rows from the 'Usage' table

-- Now create the Manufacturer table:

Create table Manufacturer(
    ManufactureID int,                  -- ManufactureID column of type INT to store unique manufacturer IDs (e.g., 1000, 1001)
    ManufactureName Varchar(50),         -- ManufactureName column of type VARCHAR(50) to store the name of the manufacturer (e.g., 'Nike', 'Addidas')
    Constraint PK_ManufactureID Primary Key(ManufactureID)  -- Define ManufactureID as the primary key, ensuring uniqueness and non-nullability
);

-- Insert values into the Manufacturer table:
insert into Manufacturer(ManufactureID, ManufactureName)
values
(1000, 'Nike'),                       -- Insert ManufactureID 1000 with name 'Nike'
(1001, 'Addidas'),                    -- Insert ManufactureID 1001 with name 'Addidas'
(1002, 'Puma');                       -- Insert ManufactureID 1002 with name 'Puma'

-- Display the data from the Manufacturer table:
Select * from Manufacturer;  -- Retrieves all rows from the 'Manufacturer' table

-- Display the data from the Usage table again:
Select * from Usage;  -- Retrieves all rows from the 'Usage' table again (showing the previous data)
Select * from Manufacturer;  -- Retrieves all rows from the 'Manufacturer' table again (showing the previous data)


--Characters Limit
--char  8000 limit n bytes
--varchar 8000  limit n+2 byes
--varchar(max) 2^31 chars  n+2 byes
--text 2147483647   n+2 byes

-- Add new columns to the 'product' table.
alter table product 
add UsageID char(5),    -- Add a column 'UsageID' of type char(5) to store usage identifiers, which will be a foreign key referencing the 'Usage' table.
    ManufactureID int,  -- Add a column 'ManufactureID' of type int to store manufacturer IDs, which will be a foreign key referencing the 'Manufacturer' table.
    CategoryID int,     -- Add a column 'CategoryID' of type int to store category IDs, which will be a foreign key referencing the 'Category' table.
    ColorID Char(6),    -- Add a column 'ColorID' of type char(6) to store color IDs, which will be a foreign key referencing the 'Color' table.
    SizeID int;         -- Add a column 'SizeID' of type int to store size IDs, which will be a foreign key referencing the 'Size' table.

-- Execute the 'sp_help' stored procedure to retrieve details about the 'Size' table.
exec sp_help Size;

-- Execute the 'sp_help' stored procedure to retrieve details about the 'Category' table.
exec sp_help Category;

-- Execute the 'sp_help' stored procedure to retrieve details about the 'Color' table.
exec sp_help Color;

-- Execute the 'sp_help' stored procedure to retrieve details about the 'product' table.
exec sp_help product;

-- Execute the 'sp_help' stored procedure to retrieve details about the 'Usage' table.
exec sp_help Usage;

-- Execute the 'sp_help' stored procedure to retrieve details about the 'Manufacturer' table.
exec sp_help Manufacturer;

-- Add a foreign key constraint to the 'SizeID' column in the 'product' table, referencing the 'SizeID' column in the 'Size' table.
alter table product add constraint PK_SIZE_1 Foreign Key(SizeID) References Size(SizeID)
On Update Cascade       -- This ensures that if the 'SizeID' value in the 'Size' table is updated, it will automatically update in the 'product' table as well.
On delete Cascade;     -- This ensures that if a record in the 'Size' table is deleted, all related records in the 'product' table will be deleted as well.

-- Add a foreign key constraint to the 'CategoryID' column in the 'product' table, referencing the 'Category' column in the 'Category' table.
alter table product add constraint PK_CategoryID_1 Foreign Key(CategoryID) References Category(Category)
On Update Cascade      -- If the 'Category' value in the 'Category' table is updated, it will automatically propagate to the 'product' table.
On delete Cascade;    -- If a record in the 'Category' table is deleted, all related records in the 'product' table will also be deleted.


-- Add a foreign key constraint to the 'ColorID' column in the 'product' table, referencing the 'ColorID' column in the 'Color' table.
alter table product add constraint PK_Color_1 Foreign Key(ColorID) References Color(ColorID)
On Update Cascade      -- If the 'ColorID' value in the 'Color' table is updated, it will automatically update in the 'product' table.
On delete Cascade;    -- If a record in the 'Color' table is deleted, all related records in the 'product' table will be deleted.


-- Add a foreign key constraint to the 'UsageID' column in the 'product' table, referencing the 'UsageID' column in the 'Usage' table.
alter table product add constraint Pk_Usage Foreign Key(UsageID) References Usage(UsageID)
On Update Cascade      -- If the 'UsageID' value in the 'Usage' table is updated, it will automatically update in the 'product' table.
On delete Cascade;    -- If a record in the 'Usage' table is deleted, all related records in the 'product' table will be deleted.


-- Add a foreign key constraint to the 'ManufactureID' column in the 'product' table, referencing the 'ManufactureID' column in the 'Manufacturer' table.
alter table product add constraint PK_Manufacturer Foreign Key(ManufactureID) References Manufacturer(ManufactureID)
On Update Cascade     -- If the 'ManufactureID' value in the 'Manufacturer' table is updated, it will automatically update in the 'product' table.
On delete Cascade;   -- If a record in the 'Manufacturer' table is deleted, all related records in the 'product' table will be deleted.



-- Query the 'INFORMATION_SCHEMA.TABLE_CONSTRAINTS' view to get details about the foreign key constraints defined in the database.
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS;
-- This will show all the constraints (primary keys, foreign keys, etc.) that exist in the database. It helps you verify that all constraints were added successfully.

select * from product

Alter table product
drop PK_CategoryID_1;

Alter table product
drop Column CategoryID;