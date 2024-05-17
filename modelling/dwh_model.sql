USE [ApartmentsxCrimeDWH]
GO
/****** Object:  Table [dbo].[DimApartment]    Script Date: 17.05.2024 12:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimApartment](
	[ApartmentID] [bigint] IDENTITY(1,1) NOT NULL,
	[ApartmentSource] [nvarchar](50) NOT NULL,
	[OfferTitle] [nvarchar](100) NOT NULL,
	[OfferBody] [text] NOT NULL,
	[PaymentFrequency] [nvarchar](50) NOT NULL,
	[SquareFeet] [decimal](18, 0) NOT NULL,
	[SquareMeters] [decimal](18, 0) NOT NULL,
	[Bedrooms] [int] NOT NULL,
	[Bathrooms] [decimal](18, 0) NOT NULL,
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
	[hasFireplace] [bit] NOT NULL,
 CONSTRAINT [PK_DimApartment] PRIMARY KEY CLUSTERED 
(
	[ApartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDate]    Script Date: 17.05.2024 12:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[Hours] [int] NOT NULL,
	[Minutes] [int] NOT NULL,
	[TimeOfTheDay] [varchar](10) NOT NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimLocation]    Script Date: 17.05.2024 12:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimLocation](
	[LocationID] [bigint] IDENTITY(1,1) NOT NULL,
	[PremisName] [nvarchar](100) NOT NULL,
	[Latitude] [decimal](18, 0) NOT NULL,
	[Longtitude] [decimal](18, 0) NOT NULL,
	[PoliceStationAssignedCode] [char](2) NOT NULL,
 CONSTRAINT [PK_DimLocation] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactCrimeEvent]    Script Date: 17.05.2024 12:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCrimeEvent](
	[CrimeEventID] [bigint] IDENTITY(1,1) NOT NULL,
	[LocationID] [bigint] NOT NULL,
	[EventKey] [int] NOT NULL, -- KLUCZ ZDEGENEROWANY w pierwotnej tabeli DR_NO
	[Date] [date] NOT NULL,
	[CrimeName] [nvarchar](50) NOT NULL,
	[WeaponName] [nvarchar](50) NOT NULL,
	[VictimSex] [char](1) NOT NULL,
	[VictimDescent] [char](1) NOT NULL,
	[VictimAge] [int] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[ResolvedDate] [date] NULL, -- korzystamy z accumulative snapshot fact table (w przysz³oœci przewidujemy datê zakoñczenia sprawy i zmianê statusu)
 CONSTRAINT [PK_FactCrimeEvent] PRIMARY KEY CLUSTERED 
(
	[CrimeEventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactRentalOffer]    Script Date: 17.05.2024 12:51:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactRentalOffer](
	[OfferID] [bigint] IDENTITY(1,1) NOT NULL,
	[ApartmentID] [bigint] NOT NULL,
	[LocationID] [bigint] NOT NULL,
	[Date] [date] NOT NULL,
	[Price] [money] NOT NULL,
	[Currency] [char](3) NOT NULL,
 CONSTRAINT [PK_FactRentalOffer] PRIMARY KEY CLUSTERED 
(
	[OfferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactCrimeEvent]  WITH CHECK ADD  CONSTRAINT [FK_FactCrimeEvent_DimDate] FOREIGN KEY([Date])
REFERENCES [dbo].[DimDate] ([Date])
GO
ALTER TABLE [dbo].[FactCrimeEvent] CHECK CONSTRAINT [FK_FactCrimeEvent_DimDate]
GO
ALTER TABLE [dbo].[FactCrimeEvent]  WITH CHECK ADD  CONSTRAINT [FK_FactCrimeEvent_DimDate1] FOREIGN KEY([ResolvedDate])
REFERENCES [dbo].[DimDate] ([Date])
GO
ALTER TABLE [dbo].[FactCrimeEvent] CHECK CONSTRAINT [FK_FactCrimeEvent_DimDate1]
GO
ALTER TABLE [dbo].[FactCrimeEvent]  WITH CHECK ADD  CONSTRAINT [FK_FactCrimeEvent_DimLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[DimLocation] ([LocationID])
GO
ALTER TABLE [dbo].[FactCrimeEvent] CHECK CONSTRAINT [FK_FactCrimeEvent_DimLocation]
GO
ALTER TABLE [dbo].[FactRentalOffer]  WITH CHECK ADD  CONSTRAINT [FK_FactRentalOffer_DimApartment] FOREIGN KEY([ApartmentID])
REFERENCES [dbo].[DimApartment] ([ApartmentID])
GO
ALTER TABLE [dbo].[FactRentalOffer] CHECK CONSTRAINT [FK_FactRentalOffer_DimApartment]
GO
ALTER TABLE [dbo].[FactRentalOffer]  WITH CHECK ADD  CONSTRAINT [FK_FactRentalOffer_DimDate] FOREIGN KEY([Date])
REFERENCES [dbo].[DimDate] ([Date])
GO
ALTER TABLE [dbo].[FactRentalOffer] CHECK CONSTRAINT [FK_FactRentalOffer_DimDate]
GO
ALTER TABLE [dbo].[FactRentalOffer]  WITH CHECK ADD  CONSTRAINT [FK_FactRentalOffer_DimLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[DimLocation] ([LocationID])
GO
ALTER TABLE [dbo].[FactRentalOffer] CHECK CONSTRAINT [FK_FactRentalOffer_DimLocation]
GO
