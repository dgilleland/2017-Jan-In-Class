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
    Province        char(2)         NOT NULL,
    PostalCode      char(6)         NOT NULL,
    PhoneNumber     char(13)            NULL    -- Optional - can be "blank"
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
    Subtotal        money                   NOT NULL,
    GST             money                   NOT NULL,
    Total           money                   NOT NULL
)

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5)
        CONSTRAINT PK_InventoryItems_ItemNumber
            PRIMARY KEY                 NOT NULL,
    ItemDescription     varchar(50)     NOT NULL,
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
    Quantity        int                 NOT NULL,
    SellingPrice    money               NOT NULL,
    Amount          money               NOT NULL,
    -- The following is a Table Constraint
    --  Composite Keys must be done as Table Constraints
    CONSTRAINT PK_OrderDetails_OrderNumber_ItemNumber
        PRIMARY KEY (OrderNumber, ItemNumber)
)

GO
-- End of tables for Specification Document 1



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