USE master
GO
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ApartmentsxCrimeDWH')
BEGIN
	ALTER DATABASE [ApartmentsxCrimeDWH] set single_user with rollback immediate
	DROP DATABASE [ApartmentsxCrimeDWH];
END
GO

CREATE DATABASE [ApartmentsxCrimeDWH]
GO
USE [ApartmentsxCrimeDWH]
GO


CREATE TABLE [dbo].[DimApartment](
	[ApartmentID] [bigint] NOT NULL,
	[ApartmentSource] [nvarchar](50) NOT NULL,
	[OfferTitle] [nvarchar](100) NOT NULL,
	[OfferBody] [text] NOT NULL,
	[PaymentFrequency] [nvarchar](50) NOT NULL,
	[allowsPets] [bit] NOT NULL,
	[allowsDogs] [bit] NOT NULL,
	[allowsCats] [bit] NOT NULL,
	[hasPhoto] [bit] NOT NULL,
	[hasParking] [bit] NOT NULL,
	[hasGym] [bit] NOT NULL,
	[hasPool] [bit] NOT NULL,
	[hasDishwasher] [bit] NOT NULL,
	[hasAC] [bit] NOT NULL,
	[hasElevator] [bit] NOT NULL,
	[hasPatioOrDeck] [bit] NOT NULL,
	[hasPlayground] [bit] NOT NULL,
	[hasStorage] [bit] NOT NULL,
	[hasClubhouse] [bit] NOT NULL,
	[hasFireplace] [bit] NOT NULL)
 -- mo¿e dodaæ wiêcej has na podstawie kolumny amenities

CREATE TABLE [dbo].[DimDate](
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
	[LocationID] [bigint] NOT NULL,
	[PremisCode] [char](3) NOT NULL,
	[PremisDesc] [nvarchar](100) NOT NULL,
	[Latitude] [decimal] NOT NULL,
	[Longtitude] [decimal] NOT NULL,
	[PoliceStationAssignedCode] [char](2))


CREATE TABLE [dbo].[DimCrime](
	[CrimeID] [bigint] NOT NULL,
	[CrimeCode] [char](3) NOT NULL,
	[CrimeName] [nvarchar](50) NOT NULL,
	-- mo¿e dodaæ wybrane Modus Operandi jako zmienne binarne
	[VictimSex] [char](1) NOT NULL,
	[VictimDescent] [char](1) NOT NULL,
	[hasWeapon] [bit] NOT NULL,
	[WeaponCode] [char](3) ,
	[WeaponName] [nvarchar](50),
	[Status] [nvarchar](50))

CREATE TABLE [dbo].[FactCrimeEvent](
	[CrimeEventID] [bigint] NOT NULL,
	-- czasem w jednym zdarzeniu pope³niono pare przestêpstw
	[CrimeID] [bigint] NOT NULL,
	[LocationID] [bigint] NOT NULL,
	[Date] [date] NOT NULL,
	[VictimAge] [int] NOT NULL,
	[NumberOfCrimesAtEvent] [int] NOT NULL)

	CREATE TABLE [dbo].[FactRentalOffer](
	[OfferID] [bigint] NOT NULL,
	[ApartmentID] [bigint] NOT NULL,
	[LocationID] [bigint] NOT NULL,
	[Date] [date] NOT NULL,
	[NumberOfBedrooms] [decimal] NOT NULL,
	[NumberOfBathrooms] [decimal] NOT NULL,
	[Price] [money] NOT NULL,
	[Currency] [char](3) NOT NULL,
	[SquareFeet] [decimal] NOT NULL,
	[SquareMeters] [decimal] NOT NULL)
	