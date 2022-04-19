/*
HUB TEMPLATE
*/



/* HUB_EMPLOYEES */
CREATE TABLE [raw].[HUB_EMPLOYEES](
				[HK_EmployeeID] [varbinary](35) NOT NULL,
				[LOAD_DTS] [date] NOT NULL,
				[REC_SRC] [varchar](100) NOT NULL,
				[EmployeeID] [int] NOT NULL,
	CONSTRAINT [PK_HUB_EMPLOYEE] PRIMARY KEY CLUSTERED 
	(
				[HK_EmployeeID] ASC
	)ON [PRIMARY],
	CONSTRAINT [UK_HUB_EMPLOYEE] UNIQUE NONCLUSTERED
	(
				[EmployeeID] ASC
	)ON [PRIMARY],
	)ON [PRIMARY]
	; 


INSERT INTO [raw].[HUB_EMPLOYEES]
	(
		[HK_EmployeeID]
		,[LOAD_DTS]
		,[REC_SRC]
		,[EmployeeID]
	)
SELECT	  HASHBYTES( 'md5', convert( varchar(35), STG.[EmployeeID] ) )
		, GETDATE()
		, 'NORTHWIND'
		, STG.[EmployeeID] 
	FROM [dbo].[Employees] STG 
	WHERE 
	NOT EXISTS ( SELECT 1 FROM [RAW].[HUB_EMPLOYEES] HUB WHERE HUB.[EmployeeID] = STG.[EmployeeID] )
	-- and stage date = todays date // use this logic in order to perform incremental loads instead of full load
; 

select * from [raw].[HUB_EMPLOYEES]




/* HUB_ORDERS */
CREATE TABLE [raw].[HUB_ORDERS](
               [HK_OrderID] [varbinary](35) NOT NULL,
               [LOAD_DTS] [date] NOT NULL,
               [REC_SRC] [varchar](100) NOT NULL,
               [OrderID] [int] NOT NULL,
  CONSTRAINT [PK_HUB_ORDERS] PRIMARY KEY CLUSTERED 
 (
               [HK_OrderID] ASC
 )ON [PRIMARY],
  CONSTRAINT [UK_HUB_ORDERS] UNIQUE NONCLUSTERED
 (
               [OrderID] ASC
 )ON [PRIMARY],
 )ON [PRIMARY]
 ; 


INSERT INTO [raw].[HUB_ORDERS]
  (
        [HK_OrderID]
       ,[LOAD_DTS]
       ,[REC_SRC]
       ,[OrderID]
  )
SELECT	  HASHBYTES( 'md5', convert( varchar(35), STG.[OrderID] ) )
		, GETDATE()
		, 'NORTHWIND'
		, STG.[OrderID] 
 FROM [dbo].[Orders] STG 
 WHERE 
 NOT EXISTS ( SELECT 1 FROM [RAW].[HUB_ORDERS] HUB WHERE HUB.[OrderID] = STG.[OrderID] )
 -- and stage date = todays date // use this logic in order to perform incremental loads instead of full load
; 

select * from [raw].[HUB_ORDERS]





/* HUB_CUSTOMER */
CREATE TABLE [raw].[HUB_CUSTOMER](
               [HK_CustomerID] [varbinary](35) NOT NULL,
               [LOAD_DTS] [date] NOT NULL,
               [REC_SRC] [varchar](100) NOT NULL,
               [CustomerID] nvarchar(5) NOT NULL,
  CONSTRAINT [PK_HUB_CUSTOMER] PRIMARY KEY CLUSTERED 
 (
               [HK_CustomerID] ASC
 )ON [PRIMARY],
  CONSTRAINT [UK_HUB_CUSTOMER] UNIQUE NONCLUSTERED
 (
               [CustomerID] ASC
 )ON [PRIMARY],
 )ON [PRIMARY]
 ; 


INSERT INTO [raw].[HUB_CUSTOMER]
  (
        [HK_CustomerID]
       ,[LOAD_DTS]
       ,[REC_SRC]
       ,[CustomerID]
  )
SELECT	  HASHBYTES( 'md5', convert( varchar(35), STG.[CustomerID] ) )
		, GETDATE()
		, 'NORTHWIND'
		, STG.[CustomerID] 
 FROM [dbo].[Customers] STG 
 WHERE 
 NOT EXISTS ( SELECT 1 FROM [RAW].[HUB_CUSTOMER] HUB WHERE HUB.[CustomerID] = STG.[CustomerID] )
 -- and stage date = todays date // use this logic in order to perform incremental loads instead of full load
; 

select * from [raw].[HUB_CUSTOMER]





/* HUB_SHIPPERS */
CREATE TABLE [raw].[HUB_SHIPPERS](
               [HK_ShipperID] [varbinary](35) NOT NULL,
               [LOAD_DTS] [date] NOT NULL,
               [REC_SRC] [varchar](100) NOT NULL,
               [ShipperID] [int] NOT NULL,
  CONSTRAINT [PK_HUB_SHIPPERS] PRIMARY KEY CLUSTERED 
 (
               [HK_ShipperID] ASC
 )ON [PRIMARY],
  CONSTRAINT [UK_HUB_SHIPPERS] UNIQUE NONCLUSTERED
 (
               [ShipperID] ASC
 )ON [PRIMARY],
 )ON [PRIMARY]
 ; 


INSERT INTO [raw].[HUB_SHIPPERS]
  (
        [HK_ShipperID]
       ,[LOAD_DTS]
       ,[REC_SRC]
       ,[ShipperID]
  )
SELECT	  HASHBYTES( 'md5', convert( varchar(35), STG.[ShipperID] ) )
		, GETDATE()
		, 'NORTHWIND'
		, STG.[ShipperID] 
 FROM [dbo].[Shippers] STG 
 WHERE 
 NOT EXISTS ( SELECT 1 FROM [RAW].[HUB_SHIPPERS] HUB WHERE HUB.[ShipperID] = STG.[ShipperID] )
 -- and stage date = todays date // use this logic in order to perform incremental loads instead of full load
; 

select * from [raw].[HUB_SHIPPERS]


















/* HUB_PRODUCTS */
CREATE TABLE [raw].[HUB_PRODUCTS](
               [HK_ProductID] [varbinary](35) NOT NULL,
               [LOAD_DTS] [date] NOT NULL,
               [REC_SRC] [varchar](100) NOT NULL,
               [ProductID] [int] NOT NULL,
  CONSTRAINT [PK_HUB_PRODUCTS] PRIMARY KEY CLUSTERED 
 (
               [HK_ProductID] ASC
 )ON [PRIMARY],
  CONSTRAINT [UK_HUB_PRODUCTS] UNIQUE NONCLUSTERED
 (
               [ProductID] ASC
 )ON [PRIMARY],
 )ON [PRIMARY]
 ; 


INSERT INTO [raw].[HUB_PRODUCTS]
  (
        [HK_ProductID]
       ,[LOAD_DTS]
       ,[REC_SRC]
       ,[ProductID]
  )
SELECT	  HASHBYTES( 'md5', convert( varchar(35), STG.[ProductID] ) )
		, GETDATE()
		, 'NORTHWIND'
		, STG.[ProductID] 
 FROM [dbo].[Products] STG 
 WHERE 
 NOT EXISTS ( SELECT 1 FROM [RAW].[HUB_PRODUCTS] HUB WHERE HUB.[ProductID] = STG.[ProductID] )
 -- and stage date = todays date // use this logic in order to perform incremental loads instead of full load
; 

ALTER TABLE [raw].[LINK_PRODUCTS_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_HubProducts_LinksOrderDetails] FOREIGN KEY([HK_ProductID])
REFERENCES [raw].[HUB_PRODUCTS] ([HK_ProductID])
GO 





/*
LINK TEMPLATE
*/



/*  LINK_EMP_CUST_SHIP_ORDERS  */
CREATE TABLE [raw].[LINK_EMP_CUST_SHIP_ORDERS](
            [HK_Emp_Cust_Ship_Orders] [varbinary](35) NOT NULL,
            [LOAD_DTS] [date] NOT NULL,
            [REC_SRC] [varchar](100) NOT NULL,
            [HK_EmployeeID] [varbinary](35) NOT NULL,
            [HK_OrderID] [varbinary](35) NOT NULL,
			[HK_CustomerID] [varbinary](35) NOT NULL,
			[HK_ShipperID] [varbinary](35) NOT NULL
CONSTRAINT [PK_LINK_EMP_CUST_SHIP_ORDERS] PRIMARY KEY CLUSTERED 
(
            [HK_Emp_Cust_Ship_Orders] ASC
),
CONSTRAINT [UK_LINK_EMP_CUST_SHIP_ORDERS] UNIQUE NONCLUSTERED 
(
            [HK_EmployeeID] ASC,
            [HK_OrderID] ASC,
			[HK_CustomerID] ASC,
			[HK_ShipperID] ASC
)
) ON [PRIMARY]
GO

/*  ESTABILISHING RELATIONSHIPS BETWEEN LINK AND HUBS  */

ALTER TABLE [raw].[LINK_EMP_CUST_SHIP_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_LINK_EMP_CUST_SHIP_ORDERS_HUB_EMPLOYEES] FOREIGN KEY([HK_EmployeeID])
REFERENCES [raw].[HUB_EMPLOYEES] ([HK_EmployeeID])
GO

ALTER TABLE [raw].[LINK_EMP_CUST_SHIP_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_LINK_EMP_CUST_SHIP_ORDERS_HUB_ORDERS] FOREIGN KEY([HK_OrderID])
REFERENCES [raw].[HUB_ORDERS] ([HK_OrderID])
GO 

ALTER TABLE [raw].[LINK_EMP_CUST_SHIP_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_LINK_EMP_CUST_SHIP_ORDERS_HUB_CUSTOMER] FOREIGN KEY([HK_CustomerID])
REFERENCES [raw].[HUB_CUSTOMER] ([HK_CustomerID])
GO 

ALTER TABLE [raw].[LINK_EMP_CUST_SHIP_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_LINK_EMP_CUST_SHIP_ORDERS_HUB_SHIPPERS] FOREIGN KEY([HK_ShipperID])
REFERENCES [raw].[HUB_SHIPPERS] ([HK_ShipperID])
GO 



/*  LOADING LINK TABLES  */


INSERT INTO [raw].[LINK_EMP_CUST_SHIP_ORDERS]
(
    [HK_Emp_Cust_Ship_Orders]
    ,[LOAD_DTS]
    ,[REC_SRC]
    ,[HK_EmployeeID]
    ,[HK_OrderID]
	,[HK_CustomerID]
	,[HK_ShipperID]
)
SELECT distinct
 HASHBYTES( 'md5', convert( varchar(35), e.[EmployeeID] ) + convert( varchar(35), o.[OrderID] ) + convert( varchar(35), c.[CustomerID] ) + convert( varchar(35), s.[ShipperID] ) )
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,HASHBYTES( 'md5', convert( varchar(35), e.[EmployeeID] ) )	-- e.EmployeeID
,HASHBYTES( 'md5', convert( varchar(35), o.[OrderID] ) )		-- o.OrderID
,HASHBYTES( 'md5', convert( varchar(35), c.[CustomerID] ) )	-- c.CustomerID
,HASHBYTES( 'md5', convert( varchar(35), s.[ShipperID] ) )	-- s.ShipperID
FROM Orders O
INNER JOIN Customers C ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON E.EmployeeID = O.EmployeeID
INNER JOIN Shippers  S ON S.ShipperID = O.ShipVia
order by 1,2,3,4


select * from [raw].[LINK_EMP_CUST_SHIP_ORDERS]






















/*  LINK_PRODUCTS_ORDERS  */

CREATE TABLE [raw].[LINK_PRODUCTS_ORDERS](
            [HK_Product_Orders] [varbinary](35) NOT NULL,
            [LOAD_DTS] [date] NOT NULL,
            [REC_SRC] [varchar](100) NOT NULL,         
            [HK_OrderID] [varbinary](35) NOT NULL,
            [HK_ProductID] [varbinary](35) NOT NULL,
CONSTRAINT [PK_LINK_PRODUCTS_ORDERS] PRIMARY KEY CLUSTERED 
(
            [HK_Product_Orders] ASC
),
CONSTRAINT [UK_LINK_PRODUCTS_ORDERS] UNIQUE NONCLUSTERED 
(
            [HK_OrderID] ASC,
            [HK_ProductID] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [raw].[LINK_PRODUCTS_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_LinkOrderDetails_HubOrders] FOREIGN KEY([HK_OrderID])
REFERENCES [raw].[HUB_ORDERS] ([HK_OrderID])
GO 


INSERT INTO [raw].[LINK_PRODUCTS_ORDERS]
(
    [HK_Product_Orders]
    ,[LOAD_DTS]
    ,[REC_SRC]
    ,[HK_OrderID]
    ,[HK_ProductID]
)
SELECT distinct
 HASHBYTES( 'md5', convert( varchar(35), o.[OrderID] ) + convert( varchar(35), o.[ProductID] ) )
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,HASHBYTES( 'md5', convert( varchar(35), o.[OrderID] ) )	
,HASHBYTES( 'md5', convert( varchar(35), o.[ProductID] ) )	
FROM [Order Details] O
order by 4,5














/*
SAT TEMPLATE
*/


/* CREATING SATS */



/* SAT EMPLOYEE OTHERS */

CREATE TABLE [raw].[SAT_EMP_OTHERS](
               [HK_EmployeeID] [varbinary](35) NOT NULL,
               [LOAD_DTS] [date] NOT NULL,
               [REC_SRC] [varchar](100) NOT NULL,
               [Address]		[nvarchar](60) NULL,
               [City]		[nvarchar](60) NULL,
               [Region]		[nvarchar](60) NULL,
               [PostalCode]	[nvarchar](60) NULL,
               [Country]		[nvarchar](60) NULL,
               [HomePhone]	[nvarchar](60) NULL,
               [Extension]	[nvarchar](60) NULL,
               [Photo]		[image] NULL,
               [Notes]		[ntext] NULL,
               [PhotoPath]	[nvarchar](255) NULL,
  CONSTRAINT [PK_SAT_EMP_OTHERS] PRIMARY KEY CLUSTERED 
 (
               [HK_EmployeeID] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_EMP_OTHERS]  WITH CHECK ADD  CONSTRAINT [FK_SatCustomers_HubCustomers] FOREIGN KEY([HK_EmployeeID])
 REFERENCES [raw].[HUB_EMPLOYEES] ([HK_EmployeeID])
 GO 


/* LOADING SATS */

INSERT INTO [raw].[SAT_EMP_OTHERS]
 (
	[HK_EmployeeID] 
	,[LOAD_DTS] 
	,[REC_SRC] 
	,[Address] 
	,[City] 
	,[Region] 
	,[PostalCode]
	,[Country] 
	,[HomePhone]
	,[Extension]
	,[Photo]		
	,[Notes]		
	,[PhotoPath]
 )
SELECT
HE.HK_EmployeeID
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,E.Address
,E.City
,E.Region
,E.PostalCode
,E.Country
,E.HomePhone
,E.Extension
,E.Photo
,E.Notes
,E.PhotoPath
FROM Employees E
INNER JOIN RAW.HUB_EMPLOYEES HE ON HE.EmployeeID = E.EmployeeID


















/* SAT EMPLOYEE MAIN */

CREATE TABLE [raw].[SAT_EMP_MAIN](
               [HK_EmployeeID]		[varbinary](35) NOT NULL,
               [LOAD_DTS]			[date] NOT NULL,
               [REC_SRC]			[varchar](100) NOT NULL,
               [LastName]			[nvarchar](60) NULL,
               [FirstName]			[nvarchar](60) NULL,
               [Title]				[nvarchar](60) NULL,
               [TitleOfCourtesy]	[nvarchar](60) NULL,
               [BirthDate]			[datetime] NULL,
               [HireDate]			[datetime] NULL,
  CONSTRAINT [PK_SAT_EMP_MAIN] PRIMARY KEY CLUSTERED 
 (
               [HK_EmployeeID] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_EMP_MAIN]  WITH CHECK ADD  CONSTRAINT [FK_SatCustomers_HubEmployees] FOREIGN KEY([HK_EmployeeID])
 REFERENCES [raw].[HUB_EMPLOYEES] ([HK_EmployeeID])
 GO 


/* LOADING SATS */

INSERT INTO [raw].[SAT_EMP_MAIN]
 (
	 [HK_EmployeeID]		
	,[LOAD_DTS]			
	,[REC_SRC]			
	,[LastName]			
	,[FirstName]			
	,[Title]				
	,[TitleOfCourtesy]	
	,[BirthDate]			
	,[HireDate]			
 )
SELECT
HE.HK_EmployeeID
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,E.[LastName]			
,E.[FirstName]			
,E.[Title]				
,E.[TitleOfCourtesy]	
,E.[BirthDate]			
,E.[HireDate]	
FROM Employees E
INNER JOIN RAW.HUB_EMPLOYEES HE ON HE.EmployeeID = E.EmployeeID















/* SAT CUSTOMER MAIN */

CREATE TABLE [raw].[SAT_CUSTOMER_MAIN](
               [HK_CustomerID]		[varbinary](35) NOT NULL,
               [LOAD_DTS]			[date] NOT NULL,
               [REC_SRC]			[varchar](100) NOT NULL,
               [CompanyName]			[nvarchar](60) NULL,
               [ContactName]			[nvarchar](60) NULL,
               [ContactTitle]				[nvarchar](60) NULL,
  CONSTRAINT [PK_SAT_CUSTOMER_MAIN] PRIMARY KEY CLUSTERED 
 (
               [HK_CustomerID] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_CUSTOMER_MAIN]  WITH CHECK ADD  CONSTRAINT [FK_SatCustomersMain_HubCustomers] FOREIGN KEY([HK_CustomerID])
 REFERENCES [raw].[HUB_CUSTOMER] ([HK_CustomerID])
 GO 


/* LOADING SATS */

INSERT INTO [raw].[SAT_CUSTOMER_MAIN]
 (
	 [HK_CustomerID]		
	,[LOAD_DTS]			
	,[REC_SRC]			
	,[CompanyName]	
	,[ContactName]	
	,[ContactTitle]			
 )
SELECT
B.HK_CustomerID
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,A.[CompanyName]	
,A.[ContactName]	
,A.[ContactTitle]	
FROM Customers A
INNER JOIN RAW.HUB_CUSTOMER B ON A.[CustomerID] = B.[CustomerID]

















/* SAT CUSTOMER ADDRESS */

CREATE TABLE [raw].[SAT_CUST_ADDRESS](
               [HK_CustomerID]	[varbinary](35) NOT NULL,
               [LOAD_DTS]		[date] NOT NULL,
               [REC_SRC]		[varchar](100) NOT NULL,
               [Address]		[nvarchar](60) NULL,
               [City]			[nvarchar](60) NULL,
               [Region]			[nvarchar](60) NULL,
               [PostalCode]		[nvarchar](60) NULL,
               [Country]		[nvarchar](60) NULL,
               [Phone]			[nvarchar](60) NULL,
               [Fax]			[nvarchar](60) NULL,
  CONSTRAINT [PK_SAT_CUST_ADDRESS] PRIMARY KEY CLUSTERED 
 (
               [HK_CustomerID] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_CUST_ADDRESS]  WITH CHECK ADD  CONSTRAINT [FK_SatCustomersAddress_HubCustomers] FOREIGN KEY([HK_CustomerID])
 REFERENCES [raw].[HUB_CUSTOMER] ([HK_CustomerID])
 GO 

/* LOADING SATS */

INSERT INTO [raw].[SAT_CUST_ADDRESS]
 (
[HK_CustomerID]	
	,[LOAD_DTS]		
	,[REC_SRC]		
	,[Address]		
	,[City]			
	,[Region]			
	,[PostalCode]		
	,[Country]		
	,[Phone]			
	,[Fax]			
 )
SELECT
B.HK_CustomerID
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,A.[Address]		
,A.[City]			
,A.[Region]			
,A.[PostalCode]		
,A.[Country]		
,A.[Phone]			
,A.[Fax]	
FROM Customers A
INNER JOIN RAW.HUB_CUSTOMER B ON A.[CustomerID] = B.[CustomerID]





















/* SAT SHIPPERS */

CREATE TABLE [raw].[SAT_SHIPPERS](
               [HK_ShipperID]	[varbinary](35) NOT NULL,
               [LOAD_DTS]		[date] NOT NULL,
               [REC_SRC]		[varchar](100) NOT NULL,
               [CompanyName]		[nvarchar](60) NULL,
               [Phone]			[nvarchar](60) NULL,
  CONSTRAINT [PK_SAT_SHIPPERS] PRIMARY KEY CLUSTERED 
 (
               [HK_ShipperID] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_SHIPPERS]  WITH CHECK ADD  CONSTRAINT [FK_SatShippers_HubShippers] FOREIGN KEY([HK_ShipperID])
 REFERENCES [raw].[HUB_SHIPPERS] ([HK_ShipperID])
 GO 

/* LOADING SATS */

INSERT INTO [raw].[SAT_SHIPPERS]
 (
[HK_ShipperID]	
	,[LOAD_DTS]		
	,[REC_SRC]		
	,[CompanyName]		
	,[Phone]					
 )
SELECT
B.[HK_ShipperID]
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
	,A.[CompanyName]		
	,A.[Phone]		
FROM Shippers A
INNER JOIN RAW.HUB_SHIPPERS B ON A.[ShipperID] = B.[ShipperID]























/* SAT ORDERS MAIN */

CREATE TABLE [raw].[SAT_ORDERS](
               [HK_OrderID]		[varbinary](35) NOT NULL,
               [LOAD_DTS]		[date] NOT NULL,
               [REC_SRC]		[varchar](100) NOT NULL,
               [OrderDate]		DATETIME NULL,
               [RequiredDate]	DATETIME NULL,
			   [ShippedDate]		DATETIME NULL,
			   [Freight]			money NULL,
			   [ShipName]			[nvarchar](60) NULL,
			   [ShipAddress]		[nvarchar](60) NULL,
			   [ShipCity]			[nvarchar](60) NULL,
			   [ShipRegion]		[nvarchar](60) NULL,
			   [ShipPostalCode]	[nvarchar](60) NULL,
			   [ShipCountry]		[nvarchar](60) NULL,
  CONSTRAINT [FK_SAT_ORDERS_MAIN] PRIMARY KEY CLUSTERED 
 (
               [HK_OrderID] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_SatOrders_HubOrders] FOREIGN KEY([HK_OrderID])
 REFERENCES [raw].[HUB_ORDERS] ([HK_OrderID])
 GO 

/* LOADING SATS */

INSERT INTO [raw].[SAT_ORDERS]
 (
	[HK_OrderID]		
	,[LOAD_DTS]		
	,[REC_SRC]		
	,[OrderDate]		
	,[RequiredDate]	
	,[ShippedDate]	
	,[Freight]		
	,[ShipName]		
	,[ShipAddress]	
	,[ShipCity]		
	,[ShipRegion]		
	,[ShipPostalCode]	
	,[ShipCountry]					
 )
SELECT
B.[HK_OrderID]
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
	,a.[OrderDate]		
	,a.[RequiredDate]	
	,a.[ShippedDate]	
	,a.[Freight]		
	,a.[ShipName]		
	,a.[ShipAddress]	
	,a.[ShipCity]		
	,a.[ShipRegion]		
	,a.[ShipPostalCode]	
	,a.[ShipCountry]	
FROM Orders A
INNER JOIN RAW.HUB_ORDERS B ON A.[OrderID] = B.[OrderID]




























/* SAT SAT_PROD_ORDERS */

drop table [raw].[SAT_PROD_ORDERS]

CREATE TABLE [raw].[SAT_PROD_ORDERS](
               [HK_Product_Orders]		[varbinary](35) NOT NULL,
               [LOAD_DTS]			[date] NOT NULL,
               [REC_SRC]			[varchar](100) NOT NULL,
               [UnitPrice]			money NULL,
               [Quantity]			smallint NULL,
			   [Discount]			real NULL,
  CONSTRAINT [FK_SAT_PROD_ORDERS] PRIMARY KEY CLUSTERED 
 (
               [HK_Product_Orders] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_PROD_ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_SatOrderDetails_LinkProduct_Orders] FOREIGN KEY([HK_Product_Orders])
 REFERENCES [raw].[LINK_PRODUCTS_ORDERS] ([HK_Product_Orders])
 GO 

/* LOADING SATS */

INSERT INTO [raw].[SAT_PROD_ORDERS]
 (
[HK_Product_Orders]	
,[LOAD_DTS]			
,[REC_SRC]			
,[UnitPrice]			
,[Quantity]			
,[Discount]							
 )
SELECT
B.[HK_Product_Orders]
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,a.[UnitPrice]			
,a.[Quantity]			
,a.[Discount]		
FROM [Order Details] A
INNER JOIN RAW.LINK_PRODUCTS_ORDERS B 
ON  HASHBYTES( 'md5', convert( varchar(35), A.[OrderID] ) )			= B.HK_OrderID
AND HASHBYTES( 'md5', convert( varchar(35), A.[ProductID] ) )		= B.HK_ProductID


SELECT * FROM RAW.[SAT_PROD_ORDERS]




























/* SAT SAT_PROD_MAIN */



CREATE TABLE [raw].[SAT_PROD_MAIN](
               [HK_ProductID]		[varbinary](35) NOT NULL,
               [LOAD_DTS]			[date] NOT NULL,
               [REC_SRC]			[varchar](100) NOT NULL,
               [ProductName]		nvarchar(60) NOT NULL,
               [QuantityPerUnit]	nvarchar(60) NULL,
			   [UnitPrice]			money NULL,
			   [UnitsInStock]		smallint NULL,
			   [UnitsOnOrder]		smallint NULL,
			   [ReorderLevel]		smallint NULL,
			   [Discontinued]		bit NULL,
  CONSTRAINT [FK_SAT_PROD_MAIN] PRIMARY KEY CLUSTERED 
 (
               [HK_ProductID] ASC,
               [LOAD_DTS] ASC
 ) ON [PRIMARY]
 ) ON [PRIMARY]
 GO
  
 ALTER TABLE [raw].[SAT_PROD_MAIN]  WITH CHECK ADD  CONSTRAINT [FK_SatProdMain_HubProducts] FOREIGN KEY([HK_ProductID])
 REFERENCES [raw].[HUB_PRODUCTS] ([HK_ProductID])
 GO 

/* LOADING SATS */

INSERT INTO [raw].[SAT_PROD_MAIN]
 (
               [HK_ProductID]		,
               [LOAD_DTS]			,
               [REC_SRC]			,
               [ProductName]		,
               [QuantityPerUnit]	,
			   [UnitPrice]			,
			   [UnitsInStock]		,
			   [UnitsOnOrder]		,
			   [ReorderLevel]		,
			   [Discontinued]			
 )
SELECT
B.[HK_ProductID]
,'2022-04-12' --'GETDATE() REPLACEING GETDATE() HERE IN ORDER TO MIMIC THAT DATA WERE LOADED THE SAME DAY HUB DATA LOADED
,'NORTHWIND'
,a.[ProductName]		
,a.[QuantityPerUnit]	
,a.[UnitPrice]		
,a.[UnitsInStock]	
,a.[UnitsOnOrder]	
,a.[ReorderLevel]	
,a.[Discontinued]		
FROM Products A
INNER JOIN RAW.HUB_PRODUCTS B ON A.[ProductID] = B.[ProductID]



SELECT * FROM RAW.[SAT_PROD_ORDERS]