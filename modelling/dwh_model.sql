DROP DATABASE [apartments_and_crime_dwh]

CREATE DATABASE [apartments_and_crime_dwh]
GO
USE [apartments_and_crime_dwh]
GO

CREATE TABLE [dbo].[DimApartment](
	[ApartmentKey] [bigint] NOT NULL,
	[ApartmentSource] [nvarchar](50) NOT NULL,
	[OfferTitle] [nvarchar](100) NOT NULL,
	[OfferBody] [text] NOT NULL,
	[hasParking] [bit] NOT NULL,
	[hasGym] [bit] NOT NULL,
	[hasPool] [bit] NOT NULL,
	[hasDishwasher] [bit] NOT NULL,
	[hasAC] [bit] NOT NULL,
	[hasElevator] [bit] NOT NULL,
	[hasPatioDeck] [bit] NOT NULL,
	[hasPlayground] [bit] NOT NULL,
	[hasStorage] [bit] NOT NULL,
	[hasClubhouse] [bit] NOT NULL,
	[hasFireplace] [bit] NOT NULL)
 -- mo¿e dodaæ wiêcej has na podstawie kolumny amenities

CREATE TABLE [dbo].[DimDate](
	[DateKey] [bigint] NOT NULL,
	[Date] [date] NOT NULL,
	[DayNumber] [tinyint] NOT NULL,
	[DaySuffix] [char](2) NOT NULL,
	[WeekDayNumber] [tinyint] NOT NULL,
	[WeekDayName] [varchar](10) NOT NULL,
	[WeekendFlag] [bit] NOT NULL,
	[MonthNumber] [tinyint] NOT NULL,
	[MonthName] [varchar](10) NOT NULL,
	[QuarterNumber] [tinyint] NOT NULL,
	[QuarterName] [varchar](6) NOT NULL,
	[YearNumber] [int] NOT NULL,
	[Hours][int] NOT NULL,
	[Minutes] [int] NOT NULL,
	[AM] [bit] NOT NULL,
	[PM] [bit] NOT NULL,
	[night] [bit] NOT NULL,
	[morning] [bit] NOT NULL,
	[afternoon] [bit] NOT NULL,
	[evening] [bit] NOT NULL
)
CREATE TABLE [dbo].[DimLocation](
	[LocationKey] [bigint] NOT NULL,
	[PremisCode] [char](3) NOT NULL,
	[PremisDesc] [nvarchar](100) NOT NULL,
	[LAT] [nvarchar](100) NOT NULL,
	[LON] [nvarchar](50) NOT NULL)

CREATE TABLE [dbo].[DimCrime](
	[ProductKey] [bigint] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[QuantityPerUnit] [nvarchar](50) NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[StockUnitsCount] [smallint] NOT NULL,
	[OrderUnitsCount] [smallint] NOT NULL,
	[ReorderLevelNumber] [smallint] NOT NULL,
	[DiscontinuedFlag] [bit] NOT NULL)

CREATE TABLE [dbo].[FactCrimeEvent](
	[OrderFactKey] [bigint] NOT NULL,
	[OrderKey] [bigint] NOT NULL,
	[ProductKey] [bigint] NOT NULL,
	[CustomerKey] [bigint] NOT NULL,
	[EmployeeKey] [bigint] NOT NULL,
	[ShipDetailKey] [bigint] NOT NULL,
	[ProductSupplierKey] [bigint] NOT NULL,
	[OrderDateKey] [bigint] NOT NULL,
	[RequiredDateKey] [bigint] NOT NULL,
	[ShippedDateKey] [bigint] NOT NULL,
	[FreightAmount] [money] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[DiscountPercent] [real] NOT NULL)

	CREATE TABLE [dbo].[FactRentalOffer](
	[OrderFactKey] [bigint] NOT NULL,
	[OrderKey] [bigint] NOT NULL,
	[ProductKey] [bigint] NOT NULL,
	[CustomerKey] [bigint] NOT NULL,
	[EmployeeKey] [bigint] NOT NULL,
	[ShipDetailKey] [bigint] NOT NULL,
	[ProductSupplierKey] [bigint] NOT NULL,
	[OrderDateKey] [bigint] NOT NULL,
	[RequiredDateKey] [bigint] NOT NULL,
	[ShippedDateKey] [bigint] NOT NULL,
	[FreightAmount] [money] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[DiscountPercent] [real] NOT NULL)