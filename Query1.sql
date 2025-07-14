USE [Exercise1]
GO

CREATE TABLE Plants(
	PlantID int IDENTITY(1,1) NOT NULL,
	Name varchar(50) NOT NULL,
	City varchar(30) NOT NULL,
	Country varchar(30) NOT NULL,
	AreaSqm decimal(10, 2) NOT NULL,
	StartYear int NOT NULL,
)
GO

CREATE TABLE CarModel(
	CarID int IDENTITY(1,1) NOT NULL,
	Name varchar(30) NOT NULL,
	Type varchar(20) NOT NULL,
	Year int NOT NULL,
	Color varchar(30) NOT NULL,
	FuelType varchar(20) NOT NULL,
	EngineCapacity decimal(8, 2) NOT NULL,
	Price int NOT NULL,
	MarketCategory varchar(20) NOT NULL,
	)
	GO

CREATE TABLE ProductionPlan(
	PlanID int IDENTITY(1,1) NOT NULL,
	PlanName varchar(20) NOT NULL,
	month tinyint NOT NULL,
	year smallint NOT NULL,
	TargetUnits int NOT NULL,
	notes varchar(200) NULL,
	created_at datetime NULL,
	updated_at datetime NULL,
	)
	GO

CREATE TABLE Dealer(
	[DealerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[Province] [varchar](20) NOT NULL,
	[StartYear] [smallint] NULL,
	[isActive] [bit] NOT NULL,
	)
	GO

CREATE TABLE CarSale(
	[SaleID] [int] IDENTITY(1,1) NOT NULL,
	[BuyerName] [varchar](150) NOT NULL,
	[ModelId] [int] NOT NULL,
	[SaleDate] [date] NOT NULL,
	[SalePrice] [decimal](15, 2) NULL,
	[IsPaidInFull] [bit] NOT NULL,
	)
	GO

CREATE TABLE MaintenanceLogs(
	[MaintenanceLogId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](150) NOT NULL,
	[ModelId] [int] NOT NULL,
	[ServiceDate] [date] NOT NULL,
	[ServiceType] [varchar](100) NOT NULL,
	[ServiceCenterName] [varchar](150) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	)
	GO

CREATE TABLE SpareParts(
	[PartId] [int] IDENTITY(1,1) NOT NULL,
	[PartName] [varchar](150) NOT NULL,
	[PartNumber] [varchar](50) NOT NULL,
	[PartCategory] [varchar](100) NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[UnitPrice] [decimal](15, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	)
	GO

CREATE TABLE CustomerFeedback(
	[FeedbackId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](150) NOT NULL,
	[ModelId] [int] NOT NULL,
	[FeedbackDate] [date] NOT NULL,
	[SatisfactionRating] [tinyint] NOT NULL,
	[Comments] [varchar](max) NULL,
	)
	GO
