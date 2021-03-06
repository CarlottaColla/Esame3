USE [master]
GO
/****** Object:  Database [POLIZIA]    Script Date: 12/02/2021 12:55:53 ******/
CREATE DATABASE [POLIZIA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'POLIZIA', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\POLIZIA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'POLIZIA_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\POLIZIA_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [POLIZIA] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [POLIZIA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [POLIZIA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [POLIZIA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [POLIZIA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [POLIZIA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [POLIZIA] SET ARITHABORT OFF 
GO
ALTER DATABASE [POLIZIA] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [POLIZIA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [POLIZIA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [POLIZIA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [POLIZIA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [POLIZIA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [POLIZIA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [POLIZIA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [POLIZIA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [POLIZIA] SET  ENABLE_BROKER 
GO
ALTER DATABASE [POLIZIA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [POLIZIA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [POLIZIA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [POLIZIA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [POLIZIA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [POLIZIA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [POLIZIA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [POLIZIA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [POLIZIA] SET  MULTI_USER 
GO
ALTER DATABASE [POLIZIA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [POLIZIA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [POLIZIA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [POLIZIA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [POLIZIA] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [POLIZIA] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [POLIZIA] SET QUERY_STORE = OFF
GO
USE [POLIZIA]
GO
/****** Object:  Table [dbo].[Agente_di_polizia]    Script Date: 12/02/2021 12:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agente_di_polizia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[Codice_fiscalse] [nvarchar](16) NOT NULL,
	[Data_nascita] [date] NOT NULL,
	[Anni_servizio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Codice_fiscalse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Area_metropolitana]    Script Date: 12/02/2021 12:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area_metropolitana](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Codice_area] [nvarchar](5) NOT NULL,
	[Alto_rischio] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assegnazione]    Script Date: 12/02/2021 12:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assegnazione](
	[ID_agente] [int] NOT NULL,
	[ID_area] [int] NOT NULL,
 CONSTRAINT [PK_Assegnazione] PRIMARY KEY CLUSTERED 
(
	[ID_agente] ASC,
	[ID_area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assegnazione]  WITH CHECK ADD FOREIGN KEY([ID_agente])
REFERENCES [dbo].[Agente_di_polizia] ([ID])
GO
ALTER TABLE [dbo].[Assegnazione]  WITH CHECK ADD FOREIGN KEY([ID_area])
REFERENCES [dbo].[Area_metropolitana] ([ID])
GO
ALTER TABLE [dbo].[Agente_di_polizia]  WITH CHECK ADD  CONSTRAINT [CK_Data_Nascita] CHECK  (([Data_nascita]<'01-01-2003'))
GO
ALTER TABLE [dbo].[Agente_di_polizia] CHECK CONSTRAINT [CK_Data_Nascita]
GO
/****** Object:  StoredProcedure [dbo].[stpEliminaAgente]    Script Date: 12/02/2021 12:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[stpEliminaAgente] @id INT
AS
BEGIN
		--eliminazione di un agente esistente
		DELETE FROM Agente_di_polizia WHERE ID = @id
		--esempio di esecuzione:
		--EXEC stpEliminaAgente @id=7
RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[stpInserisciAgente]    Script Date: 12/02/2021 12:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[stpInserisciAgente] @nome NVARCHAR(30), @cognome NVARCHAR(50),@cf NVARCHAR(16),
									  @dataNat DATE, @anniServizio INT
AS
BEGIN
	 --inserimento di un nuovo agente(prendere in input i dati necessari)
	BEGIN TRY
		INSERT INTO Agente_di_polizia VALUES(@nome,@cognome,@cf,@dataNat,@anniServizio)
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
	END CATCH
	--esempio di esecuzione
	--EXEC stpInserisciAgente @nome = 'Prova', @cognome = 'prova', @cf='SDDFGL67A23T445D', @dataNat = '03-10-2009',
	--@anniServizio = 5
RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[stpNumeroAgentiPerArea]    Script Date: 12/02/2021 12:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[stpNumeroAgentiPerArea]
AS
BEGIN
--visualizzare il numero di agenti assegnati per ogni area geografica (numero agenti e codice area)
	SELECT Area_metropolitana.Codice_area, COUNT(Assegnazione.ID_agente) AS Numero_Agenti
	FROM Agente_di_polizia
	INNER JOIN Assegnazione
	ON Assegnazione.ID_agente=Agente_di_polizia.ID
	INNER JOIN Area_metropolitana
	ON Area_metropolitana.ID=Assegnazione.ID_area
	GROUP BY Area_metropolitana.Codice_area
	--esempio di esecuzione:
	--EXEC stpNumeroAgentiPerArea
RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[stpRischioAlto]    Script Date: 12/02/2021 12:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[stpRischioAlto]
AS
BEGIN
	--visualizzare l'elenco degli agenti che lavorano in "aree ad alto rischio" e hanno meno di 3 anni di servizio
	SELECT Agente_di_polizia.ID,Agente_di_polizia.Nome,Agente_di_polizia.Codice_fiscalse,Agente_di_polizia.Data_nascita,
	Agente_di_polizia.Anni_servizio, Area_metropolitana.Codice_area,Area_metropolitana.Alto_rischio
	FROM Agente_di_polizia
	INNER JOIN Assegnazione
	ON Assegnazione.ID_agente=Agente_di_polizia.ID
	INNER JOIN Area_metropolitana
	ON Area_metropolitana.ID=Assegnazione.ID_area
	WHERE Agente_di_polizia.Anni_servizio < 3 AND Area_metropolitana.Alto_rischio = 1
	--esempio di esecuzione
	--EXEC stpRischioAlto
RETURN 0;
END
GO
USE [master]
GO
ALTER DATABASE [POLIZIA] SET  READ_WRITE 
GO
