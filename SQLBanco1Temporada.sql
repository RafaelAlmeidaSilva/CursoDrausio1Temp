USE [master]
GO
/****** Object:  Database [dbCliente]    Script Date: 29/07/2016 12:19:31 ******/
CREATE DATABASE [dbCliente]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbCliente', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbCliente.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbCliente_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbCliente_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbCliente] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbCliente].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbCliente] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbCliente] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbCliente] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbCliente] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbCliente] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbCliente] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbCliente] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbCliente] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbCliente] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbCliente] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbCliente] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbCliente] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbCliente] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbCliente] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbCliente] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbCliente] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbCliente] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbCliente] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbCliente] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbCliente] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbCliente] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbCliente] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbCliente] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbCliente] SET  MULTI_USER 
GO
ALTER DATABASE [dbCliente] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbCliente] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbCliente] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbCliente] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dbCliente] SET DELAYED_DURABILITY = DISABLED 
GO
USE [dbCliente]
GO
/****** Object:  Table [dbo].[tblCliente]    Script Date: 29/07/2016 12:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCliente](
	[Cod_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nome_Cliente] [varchar](100) NOT NULL,
	[Data_Nascimento] [datetime] NOT NULL,
	[Sexo] [bit] NOT NULL,
	[LimiteCompra] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_tblCliente] PRIMARY KEY CLUSTERED 
(
	[Cod_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[uspClienteAlterar]    Script Date: 29/07/2016 12:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspClienteAlterar]
/*PARAMETROS*/
@IdCliente int,
@Nome varchar(100),
@DataNascimento datetime,
@Sexo bit,
@LimiteCompra decimal(18, 2)

as
begin
  
  Update
     tblCliente
  set
     Nome_Cliente = @Nome,
	 Data_Nascimento = @DataNascimento,
	 Sexo = @Sexo,
	 LimiteCompra = @LimiteCompra
  where 
     Cod_Cliente = @IdCliente

	 Select @IdCliente As Retorno
end
GO
/****** Object:  StoredProcedure [dbo].[uspClienteConsultarPorCodigo]    Script Date: 29/07/2016 12:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[uspClienteConsultarPorCodigo]
@Cod_Cliente int
as
begin

Select Cod_Cliente, Nome_Cliente, Data_Nascimento, Sexo, LimiteCompra from tblCliente

where 
   Cod_Cliente = @Cod_Cliente
end
GO
/****** Object:  StoredProcedure [dbo].[uspClienteConsultarPorNome]    Script Date: 29/07/2016 12:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[uspClienteConsultarPorNome]
 @Nome varchar(100)
as
begin

Select Cod_Cliente, Nome_Cliente, Data_Nascimento, Sexo, LimiteCompra from tblCliente

where 
   Nome_Cliente like '%' + @Nome + '%'
end
GO
/****** Object:  StoredProcedure [dbo].[uspClienteExcluir]    Script Date: 29/07/2016 12:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspClienteExcluir]
 @IdCliente int
as
begin
 
 Delete from tblCliente

 where
   Cod_Cliente = @IdCliente

select @IdCliente as Retorno 
end
GO
/****** Object:  StoredProcedure [dbo].[uspClienteInserir]    Script Date: 29/07/2016 12:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspClienteInserir]
/*PARAMETROS*/
@Nome varchar(100),
@DataNascimento datetime,
@Sexo bit,
@LimiteCompra decimal(18, 2)

as 
begin

insert into tblCliente
(
 Nome_Cliente,
 Data_Nascimento,
 Sexo,
 LimiteCompra
)
values
(
@nome,
@DataNascimento,
@Sexo,
@LimiteCompra
)

Select @@IDENTITY as Retorno


end

GO
USE [master]
GO
ALTER DATABASE [dbCliente] SET  READ_WRITE 
GO
