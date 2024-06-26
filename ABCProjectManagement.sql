USE [master]
GO
/****** Object:  Database [ABCProjectManagement]    Script Date: 2023-11-23 4:41:22 PM ******/
CREATE DATABASE [ABCProjectManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ABCProjectManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019EXPRESS\MSSQL\DATA\ABCProjectManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ABCProjectManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019EXPRESS\MSSQL\DATA\ABCProjectManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ABCProjectManagement] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ABCProjectManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ABCProjectManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ABCProjectManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ABCProjectManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ABCProjectManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ABCProjectManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ABCProjectManagement] SET  MULTI_USER 
GO
ALTER DATABASE [ABCProjectManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ABCProjectManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ABCProjectManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ABCProjectManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ABCProjectManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ABCProjectManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ABCProjectManagement] SET QUERY_STORE = OFF
GO
USE [ABCProjectManagement]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2023-11-23 4:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeNumber] [int] IDENTITY(12345,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Role] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectAssignments]    Script Date: 2023-11-23 4:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAssignments](
	[ProjectAssignmentId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeNumber] [int] NOT NULL,
	[ProjectCode] [varchar](20) NOT NULL,
	[AssignedDate] [date] NOT NULL,
	[SubmittedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectAssignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 2023-11-23 4:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectCode] [varchar](20) NOT NULL,
	[ProjectTitle] [varchar](100) NOT NULL,
	[DueDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2023-11-23 4:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeNumber], [FirstName], [LastName], [Role]) VALUES (12345, N'Mary', N'Brown', N'IT Project Manager')
INSERT [dbo].[Employees] ([EmployeeNumber], [FirstName], [LastName], [Role]) VALUES (12346, N'Richard', N'Green', N'Programmer')
INSERT [dbo].[Employees] ([EmployeeNumber], [FirstName], [LastName], [Role]) VALUES (12347, N'Michael', N'Freitag', N'Programmer')
INSERT [dbo].[Employees] ([EmployeeNumber], [FirstName], [LastName], [Role]) VALUES (12348, N'Jennifer', N'Nguyen', N'Programmer')
INSERT [dbo].[Employees] ([EmployeeNumber], [FirstName], [LastName], [Role]) VALUES (12349, N'Julia', N'Wang', N'Programmer')
INSERT [dbo].[Employees] ([EmployeeNumber], [FirstName], [LastName], [Role]) VALUES (12350, N'Marie', N'Green', N'IT Project Manager')
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[ProjectAssignments] ON 

INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [EmployeeNumber], [ProjectCode], [AssignedDate], [SubmittedDate]) VALUES (1, 12346, N'PRJ101', CAST(N'2023-09-10' AS Date), NULL)
INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [EmployeeNumber], [ProjectCode], [AssignedDate], [SubmittedDate]) VALUES (2, 12346, N'PRJ102', CAST(N'2023-09-12' AS Date), NULL)
INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [EmployeeNumber], [ProjectCode], [AssignedDate], [SubmittedDate]) VALUES (3, 12347, N'PRJ101', CAST(N'2023-09-10' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[ProjectAssignments] OFF
GO
INSERT [dbo].[Projects] ([ProjectCode], [ProjectTitle], [DueDate]) VALUES (N'PRJ101', N'Payroll Application in C#', CAST(N'2023-12-20' AS Date))
INSERT [dbo].[Projects] ([ProjectCode], [ProjectTitle], [DueDate]) VALUES (N'PRJ102', N'Property Rental Management Web App Using ASP.Net Core MVC', CAST(N'2023-11-20' AS Date))
INSERT [dbo].[Projects] ([ProjectCode], [ProjectTitle], [DueDate]) VALUES (N'PRJ103', N'Employee Management System in Java', CAST(N'2023-11-27' AS Date))
INSERT [dbo].[Projects] ([ProjectCode], [ProjectTitle], [DueDate]) VALUES (N'PRJ104', N'On-line Order Management in ASP.NET MVC', CAST(N'2023-12-03' AS Date))
INSERT [dbo].[Projects] ([ProjectCode], [ProjectTitle], [DueDate]) VALUES (N'PRJ105', N'Employee and User Management in PHP', CAST(N'2023-12-20' AS Date))
GO
INSERT [dbo].[Users] ([UserId], [Password], [Email]) VALUES (12345, N'mary12345', N'mary@yahoo.com')
INSERT [dbo].[Users] ([UserId], [Password], [Email]) VALUES (12346, N'richard12346', N'richard@gmail.com')
INSERT [dbo].[Users] ([UserId], [Password], [Email]) VALUES (12347, N'michael12347', N'michael@hotmail.com')
INSERT [dbo].[Users] ([UserId], [Password], [Email]) VALUES (12348, N'jennifer12348', N'jennifer@gmail.com')
INSERT [dbo].[Users] ([UserId], [Password], [Email]) VALUES (12349, N'julia12349', N'julia@hotmail.com')
INSERT [dbo].[Users] ([UserId], [Password], [Email]) VALUES (12350, N'marie12350', N'marie@yahoo.com')
GO
ALTER TABLE [dbo].[ProjectAssignments]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAssignmentsProjects] FOREIGN KEY([ProjectCode])
REFERENCES [dbo].[Projects] ([ProjectCode])
GO
ALTER TABLE [dbo].[ProjectAssignments] CHECK CONSTRAINT [FK_ProjectAssignmentsProjects]
GO
ALTER TABLE [dbo].[ProjectAssignments]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAssignmentsUsers] FOREIGN KEY([EmployeeNumber])
REFERENCES [dbo].[Employees] ([EmployeeNumber])
GO
ALTER TABLE [dbo].[ProjectAssignments] CHECK CONSTRAINT [FK_ProjectAssignmentsUsers]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_UsersEmployees] FOREIGN KEY([UserId])
REFERENCES [dbo].[Employees] ([EmployeeNumber])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_UsersEmployees]
GO
USE [master]
GO
ALTER DATABASE [ABCProjectManagement] SET  READ_WRITE 
GO
