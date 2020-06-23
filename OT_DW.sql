
/* Create table dbo.DimCustomer */
CREATE TABLE dbo.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  nvarchar(5)   NOT NULL
,  [CustomerName]  nvarchar(255)   NOT NULL
,  [Address]  nvarchar(255)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;



/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  date   NULL
,  [DayOfWeek]  int   NOT NULL
,  [DayName]  varchar(9)   NOT NULL
,  [DayOfMonth]  int   NOT NULL
,  [DayOfYear]  int   NOT NULL
,  [WeekOfYear]  int   NOT NULL
,  [MonthName]  varchar(9)   NOT NULL
,  [MonthOfYear]  int   NOT NULL
,  [Quarter]  int   NOT NULL
,  [Year]  int   NOT NULL
,  [IsWeekday]  bit  DEFAULT 0 NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;




/* Create table dbo.DimProduct */
CREATE TABLE dbo.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int   NOT NULL
,  [ProductName]  nvarchar(40)   NOT NULL
,  [WareHouseName]  nvarchar(40)   NOT NULL
,  [CategoryName]  nvarchar(40)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

/* Create table dbo.DimEmployee */
CREATE TABLE dbo.DimEmployee (
   [EmployeeKey]  int IDENTITY  NOT NULL
,  [EmployeeID]  int   NOT NULL
,  [EmployeeName]  nvarchar(40)   NOT NULL
,  [JobTitle]  nvarchar(30)   NOT NULL
,  [Email]  nvarchar(30)   NOT NULL
,  [Phone]  nvarchar(30)   NOT NULL
,  [HireDateKey]  nvarchar(30)   NOT NULL
,  [ManagerID]  nvarchar(30)   NOT NULL
,  [Manager]  nvarchar(30)   NOT NULL
,  [ManagerJobTitle]  nvarchar(30)   NOT NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimEmployee] PRIMARY KEY CLUSTERED 
( [EmployeeKey] )
) ON [PRIMARY]
;


/* Create table dbo.FactSales */
CREATE TABLE dbo.FactSales (
   [ProductKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [EmployeeKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [Quantity]  smallint   NOT NULL
,  [StandardCost]  money   NOT NULL
,  [UnitPrice]  money  DEFAULT 0 NOT NULL
,  [SoldAmount]  money   NOT NULL
,  [Profit]  money   NOT NULL
, CONSTRAINT [PK_dbo.FactSales] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [OrderID] )
) ON [PRIMARY]
;

/* Create table dbo.DimWareHouse */
CREATE TABLE dbo.DimWareHouse (
   [WareHouseKey]  int IDENTITY  NOT NULL
,  [WareHouseID]  int   NOT NULL
,  [WareHouseName]  nvarchar(255)   NOT NULL
,  [WareHouseAddress]  nvarchar(255)   NULL
,  [WareHouseCity]  nvarchar(50)   NULL
,  [WareHouseState]  nvarchar(255)   NULL
,  [WareHouseCountry]  nvarchar(255)   NULL
,  [WareHouseRegion]  nvarchar(50)   NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimWareHouse] PRIMARY KEY CLUSTERED 
( [WareHouseKey] )
) ON [PRIMARY]
;

/* Create table dbo.FactInventory */
CREATE TABLE dbo.FactInventory (
   [ProductKey]  int   NOT NULL
,  [WareHouseKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [UnitInStock]  int   NOT NULL
,  [UnitOnOrder]  int   NOT NULL
, CONSTRAINT [PK_dbo.FactInventory] PRIMARY KEY NONCLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;


/* Create table dbo.FactProductFeedback */
CREATE TABLE dbo.FactProductFeedback (
   [ProductKey]  int   NOT NULL
,  [WareHouseKey]  int   NOT NULL
,  [DateKey]  int   NOT NULL
,  [Shipped]  int   NOT NULL
,  [Canceled]  int   NOT NULL
, CONSTRAINT [PK_dbo.FactProductFeedback] PRIMARY KEY NONCLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;


ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_EmployeeKey FOREIGN KEY
   (
   EmployeeKey
   ) REFERENCES DimEmployee
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactInventory ADD CONSTRAINT
   FK_dbo_FactInventory_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactInventory ADD CONSTRAINT
   FK_dbo_FactInventory_WareHouseKey FOREIGN KEY
   (
   WareHouseKey
   ) REFERENCES DimWareHouse
   ( WareHouseKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactInventory ADD CONSTRAINT
   FK_dbo_FactInventory_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactProductFeedback ADD CONSTRAINT
   FK_dbo_FactProductFeedback_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactProductFeedback ADD CONSTRAINT
   FK_dbo_FactProductFeedback_WareHouseKey FOREIGN KEY
   (
   WareHouseKey
   ) REFERENCES DimWareHouse
   ( WareHouseKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactProductFeedback ADD CONSTRAINT
   FK_dbo_FactProductFeedback_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
