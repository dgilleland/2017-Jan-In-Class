/* ****************************
 * Complete Table Creation
 *************************** */
 /*
    Putting text between the [slash][asterix] and the
    [asterix][slash] means that this text inside is a
    multi-line comment.

    [CTRL] + r              -- toggles the "results" pane
    [CTRL] + [SHIFT] + r    -- intellisense - refresh the local cache
*/
-- this is a single-line comment (stars with two dashes)
-- CREATE DATABASE [ESP-A01]
USE [ESP-A01] -- this is a statement that tells us to switch to a particular database
-- Notice in the database name above, I had to "wrap" the name in square brackets
-- because the name had a hyphen in it.
-- For our objects (tables, columns, etc), we won't use hyphens or spaces, so
-- the brackets are optional...
GO  -- this statement helps to "separate" various DDL statements in our script
    -- so that they are executed as "blocks" of code.

/* DROP TABLE statements (to "clean up" the database for re-creation)  */
-- Tables from Specification Document 3

-- Tables from Specification Document 2

-- Tables from Specification Document 1
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OrderDetails')
    DROP TABLE OrderDetails
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'InventoryItems')
    DROP TABLE InventoryItems
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders')
    DROP TABLE Orders
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
    DROP TABLE Customers

GO

-- To create a database table, we use the CREATE TABLE statement.
-- Note that the order in which we create/drop tables is important
-- because of how the tables are related via Foreign Keys.
CREATE TABLE Customers
(
    -- The body of a CREATE TABLE will identify a comma-separated list of
    -- Column Declarations.
    CustomerNumber  int
        -- A constraint is some sort of restriction for what is (and isn't)
        -- an acceptable value for the column
        CONSTRAINT PK_Customers_CustomerNumber
            -- A primary key constraint means that each row of data MUST
            -- have a unique value AND that this unique value will identify
            -- or distinquish each Customer from other Customers
            -- A primary key constraint results in a CLUSTERED INDEX,
            -- which simply means that the main (or primary) way in which
            -- the data is sorted (indexed) is by the data in this column.
            PRIMARY KEY
            -- An IDENTITY constraint means the database enters values when adding rows
            -- 100 is the "seed" (starting value), and 1 is the increment
            IDENTITY(100, 1)        NOT NULL,   -- NOT NULL when data is Required
    FirstName       varchar(50)     NOT NULL,
    LastName        varchar(60)     NOT NULL,
    [Address]       varchar(40)     NOT NULL,
    City            varchar(35)     NOT NULL,
    Province        char(2)
		-- A Default Constraint means that if no data is supplied for this column
		-- during an INSERT statement, then the default data will be entered.
		CONSTRAINT DF_Customers_Province
			DEFAULT('AB')			-- Strings are in single quotes
		-- A Check Constraint means that if the supplied data does not meet the
		-- requirements of the CHECK, then it will be rejected
		CONSTRAINT CK_Customers_Province
			CHECK  (Province = 'AB' OR
			        Province = 'BC' OR
			        Province = 'SK' OR
			        Province = 'MB' OR
			        Province = 'QC' OR
			        Province = 'NT' OR
			        Province = 'NS' OR
			        Province = 'NL' OR
			        Province = 'YK' OR
			        Province = 'NU' OR
			        Province = 'PE')
					    	        NOT NULL,
    PostalCode      char(6)
        CONSTRAINT CK_Customers_PostalCode
            CHECK (PostalCode LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
            -- PostalCode must match the pattern of A#A#A#
            -- In SQL, we can enclose a character pattern inside square brackets
            -- The A-Z means a "range" of characters from A through Z
            -- whereas [0-9] means the digits 0 through 9
                                    NOT NULL,
    PhoneNumber     char(13)
        CONSTRAINT CK_Customers_PhoneNumber
            CHECK (PhoneNumber LIKE
                   '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
                                        NULL    -- Optional - can be "blank"
)

CREATE TABLE Orders
(
    OrderNumber     int
        CONSTRAINT PK_Orders_OrderNumber
            PRIMARY KEY
            IDENTITY(200, 1)                NOT NULL,
    CustomerNumber  int
        CONSTRAINT FK_Orders_CustomerNumber_Customers_CustomerNumber
            FOREIGN KEY REFERENCES
                Customers(CustomerNumber)   NOT NULL,
    [Date]          datetime                NOT NULL,
    Subtotal        money               
        CONSTRAINT CK_CustomerOrders_Subtotal
            CHECK (Subtotal > 0)            NOT NULL,
    GST             money               
        CONSTRAINT CK_CustomerOrders_GST
            CHECK (GST >= 0)                NOT NULL,
    Total           AS Subtotal + GST       -- Compute the Total instead of storing it
)

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5)
        CONSTRAINT PK_InventoryItems_ItemNumber
            PRIMARY KEY                 NOT NULL,
    ItemDescription     varchar(50)         NULL,
    CurrentSalePrice    money           NOT NULL,
    InStockCount        int             NOT NULL,
    ReorderLevel        int             NOT NULL
)

CREATE TABLE OrderDetails
(
    OrderNumber     int
        CONSTRAINT FK_OrderDetails_OrderNumber_Orders_OrderNumber
        FOREIGN KEY REFERENCES
            Orders(OrderNumber)         NOT NULL,
    ItemNumber      varchar(5)
        CONSTRAINT FK_OrderDetails_ItemNumber_InventoryItems_ItemNumber
        FOREIGN KEY REFERENCES
            InventoryItems(ItemNumber)  NOT NULL,
    Quantity        int        
        CONSTRAINT DF_OrderDetails_Quantity
            DEFAULT (1)
        CONSTRAINT CK_OrderDetails_Quantity
            CHECK (Quantity > 0)
                                        NOT NULL,
    SellingPrice    money           
        CONSTRAINT CK_OrderDetails_SellingPrice
            CHECK (SellingPrice >= 0)
                                        NOT NULL,
    Amount          AS Quantity * SellingPrice  , -- Computed Column
    -- The following is a Table Constraint
    --  Composite Keys must be done as Table Constraints
    CONSTRAINT PK_OrderDetails_OrderNumber_ItemNumber
        PRIMARY KEY (OrderNumber, ItemNumber)
)

GO
-- End of tables for Specification Document 1

-- Assuming that the database is now being used, there may be a bunch of data in the database.
-- Inserting Customer data
INSERT INTO Customers(FirstName, LastName, [Address], City, PostalCode)
    VALUES ('Clark', 'Kent', '344 Clinton Street', 'Metropolis', 'S0S0N0')
INSERT INTO Customers(FirstName, LastName, [Address], City, PostalCode)
    VALUES ('Jimmy', 'Olsen', '242 River Close', 'Bakerline', 'B4K3R1')

-- Inserting inventory items
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES ('H8726', 'Cleaning Fan belt', 29.95, 3, 5),
           ('H8621', 'Engine Fan belt', 17.45, 10, 5)

-- Inserting an order
INSERT INTO Orders(CustomerNumber, [Date], Subtotal, GST)
    VALUES (100, GETDATE(), 17.45, 0.87)
INSERT INTO OrderDetails(OrderNumber, ItemNumber, Quantity, SellingPrice)
    VALUES (200, 'H8726', 1, 17.45)
GO

-- We can see data in our tables by doing SELECT statements
-- Select the customer information
SELECT  CustomerNumber, FirstName, LastName, 
        [Address] + ' ' + City + ', ' + Province AS 'Customer Address',
        PhoneNumber
FROM    Customers

/* ***************************
 * Change Requests for Spec 1
 *  Perform table changes through ALTER statements.
 *  Syntax for ALTER TABLE can be found at
 *      http://msdn.microsoft.com/en-us/library/ms190273.aspx
 *  ALTER TABLE statements allow us to change an existing table without
 *  having to drop it or lose information in the table
 * **************************/

GO -- Calling sp_help is best done in it's own "batch"
sp_help Customers -- sp_help is a stored procedure that gives info on objects in the database
GO
-- A) Allow Address, City, Province, and Postal Code to be NULL
ALTER TABLE Customers
    ALTER COLUMN [Address] varchar(40)  NULL
GO -- this statement helps to "separate" various DDL statements in our script. It's optional.

ALTER TABLE Customers
    ALTER COLUMN City       varchar(35) NULL
GO

ALTER TABLE Customers
    ALTER COLUMN Province   char(2)     NULL
GO

ALTER TABLE Customers
    ALTER COLUMN PostalCode char(6)     NULL
GO


-- B) Add a check constraint on the First and Last name to require at least two letters.
--    % is a wildcard for zero or more characters (letter, digit, or other character)
/*
-- If a constraint already exists, it can be dropped in an ALTER TABLE statement.
ALTER TABLE Customers
    DROP CONSTRAINT CK_Customers_FirstName
GO
ALTER TABLE Customers
    DROP CONSTRAINT CK_Customers_LastName
GO
*/
ALTER TABLE Customers
    ADD CONSTRAINT CK_Customers_FirstName
        CHECK (FirstName LIKE '__%') -- the _ is a wildcard for any single character
GO
ALTER TABLE Customers
    ADD CONSTRAINT CK_Customers_LastName
        CHECK (LastName LIKE '[A-Z][A-Z]%') -- two or more letters
GO
/*
    Now, the following should fail....
    INSERT INTO Customers(FirstName, LastName)
        VALUES ('A', '')

    INSERT INTO Customers(FirstName, LastName)
        VALUES ('12Bob', '23Smith')
 */
 -- Add a few customers
INSERT INTO Customers(FirstName, LastName)
    VALUES ('Fred', 'Flintstone')
INSERT INTO Customers(FirstName, LastName)
    VALUES ('Barney', 'Rubble')
INSERT INTO Customers(FirstName, LastName, PhoneNumber)
    VALUES ('Wilma', 'Slaghoople', '(403)555-1212')
INSERT INTO Customers(FirstName, LastName, [Address], City)
    VALUES ('Betty', 'McBricker', '103 Granite Road', 'Bedrock')
GO

-- Select the customer information
SELECT   CustomerNumber, FirstName, LastName,
         [Address] + ' ' + City + ', ' + Province AS 'Customer Address',
         PhoneNumber
    FROM Customers


-- C) Add a default constraint on the Orders.Date column to use the current date.
--    GETDATE() is a global function in the SQL Server Database
--    GETDATE() will obtain the current date/time on the database server
ALTER TABLE Orders
    ADD CONSTRAINT DF_Orders_Date
        DEFAULT GETDATE() FOR [Date]
        --      \ value /    |      |
        --                   \column/
GO
-- To illustrate the default value, consider this sample row for the Orders table
INSERT INTO Orders(CustomerNumber, Subtotal, GST)
    VALUES (101, 150.00, 7.50)
-- Select the current orders
SELECT  OrderNumber, CustomerNumber, Total, [Date]
FROM    Orders

-- D) Change the InventoryItems.ItemDescription column to be NOT NULL
--    Create some sample data to demonstrate that the column currently allows NULL values
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES ('GR35A', NULL, 45.95, 8, 5)
GO
SELECT  ItemNumber, ItemDescription, CurrentSalePrice
FROM    InventoryItems

--  D-1) Imagine that we tried now to put a Default Constraint in place.
--     What would be the result of our select statement afterwards?
ALTER TABLE InventoryItems
    ADD CONSTRAINT DF_InventoryItems_Description
        DEFAULT '-no description-' FOR ItemDescription
GO
INSERT INTO InventoryItems(ItemNumber, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES ('B-95R', 45.95, 8, 5)
-- Notice that our default constraint does not *prevent* a NULL value being inserted,
-- because at present, our ItemDescription still allows for NULL values.
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES ('GR47D', NULL, 92.45, 3, 3)
GO
SELECT ItemNumber, ItemDescription, CurrentSalePrice
    FROM InventoryItems

-- Let's look at what would happen if we tried changing ItemDescription to NOT NULL
-- even though we currently have NULL values for some of the rows.
/* Select and run the following ALTER TABLE to see what would happen...
ALTER TABLE InventoryItems
    ALTER COLUMN ItemDescription varchar(50) NOT NULL
GO
*/
--  D-2) Update existing NULL column data with replacement text
--       so that, after this statement, we can then make the
--       column required
UPDATE      InventoryItems
    SET     ItemDescription = '-missing-'
    WHERE   ItemDescription IS NULL
GO
SELECT ItemNumber, ItemDescription, CurrentSalePrice
    FROM InventoryItems

--  D-3) Do the required change request: Make the ItemDescription NOT NULL
--     NOTE: If you make a column to be NOT NULL when there are existing rows with
--           NULL values for that column, then the ALTER statement should fail.
ALTER TABLE InventoryItems
    ALTER COLUMN ItemDescription varchar(50) NOT NULL
GO

-- E) Add indexes to the Customer's First and Last Name columns
--    as well as to the Item's Description column.
--    Indexes improve the performance of the database when retrieving information.


-- ===========================================================================================
/* ======================================================
 *   STUDENT  PRACTICE  (and solutions)                  
 * ====================================================== */

/*** Day 1
 *      Add simple CREATE TABLE and DROP TABLE statements
 *      for the tables in Specification Documents 2 & 3
 */

/* **********************************************
 * Specification Document 2
 * - Payments and PaymentLogDetails
 * ******************************************* */
 
/* **********************************************
 * Specification Document 3
 * - Suppliers, PurchaseOrders, PurchaseOrderItems,
 *   ChequeRegisters, PurchaseOrderPayments
 * ******************************************* */