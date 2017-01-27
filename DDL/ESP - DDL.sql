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
    CustomerNumber  int,
    FirstName       varchar(50),
    LastName        varchar(60),
    [Address]       varchar(40),
    City            varchar(35),
    Province        char(2),
    PostalCode      char(6),
    PhoneNumber     char(13)
)

CREATE TABLE Orders
(
    OrderNumber     int,
    CustomerNumber  int,
    [Date]          datetime,
    Subtotal        money,
    GST             money,
    Total           money
)

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5),
    ItemDescription     varchar(50),
    CurrentSalePrice    money,
    InStockCount        int,
    ReorderLevel        int
)

CREATE TABLE OrderDetails
(
    OrderNumber     int,
    ItemNumber      int,
    Quantity        int,
    SellingPrice    money,
    Amount          money
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