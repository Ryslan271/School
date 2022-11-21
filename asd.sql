USE [master]
GO
/****** Object:  Database [School1]    Script Date: 21.11.2022 13:02:52 ******/
CREATE DATABASE [School1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'School1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SERV1215\MSSQL\DATA\School1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'School1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SERV1215\MSSQL\DATA\School1_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [School1] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [School1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [School1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [School1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [School1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [School1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [School1] SET ARITHABORT OFF 
GO
ALTER DATABASE [School1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [School1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [School1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [School1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [School1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [School1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [School1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [School1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [School1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [School1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [School1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [School1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [School1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [School1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [School1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [School1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [School1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [School1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [School1] SET  MULTI_USER 
GO
ALTER DATABASE [School1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [School1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [School1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [School1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [School1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'School1', N'ON'
GO
ALTER DATABASE [School1] SET QUERY_STORE = OFF
GO
USE [School1]
GO
/****** Object:  User [user01]    Script Date: 21.11.2022 13:02:52 ******/
CREATE USER [user01] FOR LOGIN [user01] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Activ] [bit] NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdJobTitle] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Lastname] [varchar](50) NOT NULL,
	[Login] [int] NOT NULL,
	[Password] [int] NOT NULL,
	[Activ] [bit] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobTitle]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTitle](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_JobTitle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lesson](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[MaximumNumberOfStudents] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Lesson] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LessonEmployee]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LessonEmployee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdLesson] [int] NOT NULL,
	[IdEmployees] [int] NOT NULL,
 CONSTRAINT [PK_LessonEmployee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NumberCabinet] [int] NULL,
	[idLessonEmloyee] [int] NULL,
	[DataTimeStart] [time](7) NULL,
	[DataTimeFinich] [time](7) NULL,
	[idWeek] [int] NOT NULL,
	[Activ] [bit] NOT NULL,
 CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdClass] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Lastname] [varchar](50) NOT NULL,
	[Login] [int] NOT NULL,
	[Password] [varchar](15) NOT NULL,
	[Activ] [bit] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentLesson]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentLesson](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdLesson] [int] NOT NULL,
	[IdStudent] [int] NOT NULL,
 CONSTRAINT [PK_StudentLesson] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisitLeson]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisitLeson](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdLesson] [int] NOT NULL,
	[IdStudent] [int] NOT NULL,
	[DateVisitLessons] [date] NULL,
	[Presence] [bit] NOT NULL,
	[IdTeacher] [int] NOT NULL,
 CONSTRAINT [PK_VisitLeson] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Week]    Script Date: 21.11.2022 13:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Week](
	[id] [int] NOT NULL,
	[Name] [varchar](15) NULL,
 CONSTRAINT [PK_Week] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (2, 1, N'Жопа', N'Жопин', N'Жопович', 230001, 123, 1)
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[JobTitle] ON 

INSERT [dbo].[JobTitle] ([id], [Name]) VALUES (1, N'Преподователь')
INSERT [dbo].[JobTitle] ([id], [Name]) VALUES (2, N'Администратор')
SET IDENTITY_INSERT [dbo].[JobTitle] OFF
SET IDENTITY_INSERT [dbo].[Lesson] ON 

INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (1, N'Жопский ', 15, 1)
SET IDENTITY_INSERT [dbo].[Lesson] OFF
SET IDENTITY_INSERT [dbo].[LessonEmployee] ON 

INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (3, 1, 2)
SET IDENTITY_INSERT [dbo].[LessonEmployee] OFF
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [idWeek], [Activ]) VALUES (3, 101, 3, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 2, 1)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
INSERT [dbo].[Week] ([id], [Name]) VALUES (0, N'Воскресенье')
INSERT [dbo].[Week] ([id], [Name]) VALUES (1, N'Понедельник')
INSERT [dbo].[Week] ([id], [Name]) VALUES (2, N'Вторник')
INSERT [dbo].[Week] ([id], [Name]) VALUES (3, N'Среда')
INSERT [dbo].[Week] ([id], [Name]) VALUES (4, N'Четверг')
INSERT [dbo].[Week] ([id], [Name]) VALUES (5, N'Пятница')
INSERT [dbo].[Week] ([id], [Name]) VALUES (6, N'Суббота')
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_JobTitle] FOREIGN KEY([IdJobTitle])
REFERENCES [dbo].[JobTitle] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_JobTitle]
GO
ALTER TABLE [dbo].[LessonEmployee]  WITH CHECK ADD  CONSTRAINT [FK_LessonEmployee_Employee] FOREIGN KEY([IdEmployees])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[LessonEmployee] CHECK CONSTRAINT [FK_LessonEmployee_Employee]
GO
ALTER TABLE [dbo].[LessonEmployee]  WITH CHECK ADD  CONSTRAINT [FK_LessonEmployee_Lesson] FOREIGN KEY([IdLesson])
REFERENCES [dbo].[Lesson] ([id])
GO
ALTER TABLE [dbo].[LessonEmployee] CHECK CONSTRAINT [FK_LessonEmployee_Lesson]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_LessonEmployee] FOREIGN KEY([idLessonEmloyee])
REFERENCES [dbo].[LessonEmployee] ([id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_LessonEmployee]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Week] FOREIGN KEY([idWeek])
REFERENCES [dbo].[Week] ([id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Week]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Class] FOREIGN KEY([IdClass])
REFERENCES [dbo].[Class] ([id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Class]
GO
ALTER TABLE [dbo].[StudentLesson]  WITH CHECK ADD  CONSTRAINT [FK_StudentLesson_Lesson] FOREIGN KEY([IdLesson])
REFERENCES [dbo].[Lesson] ([id])
GO
ALTER TABLE [dbo].[StudentLesson] CHECK CONSTRAINT [FK_StudentLesson_Lesson]
GO
ALTER TABLE [dbo].[StudentLesson]  WITH CHECK ADD  CONSTRAINT [FK_StudentLesson_Student] FOREIGN KEY([IdStudent])
REFERENCES [dbo].[Student] ([id])
GO
ALTER TABLE [dbo].[StudentLesson] CHECK CONSTRAINT [FK_StudentLesson_Student]
GO
ALTER TABLE [dbo].[VisitLeson]  WITH CHECK ADD  CONSTRAINT [FK_VisitLeson_Lesson] FOREIGN KEY([IdLesson])
REFERENCES [dbo].[Lesson] ([id])
GO
ALTER TABLE [dbo].[VisitLeson] CHECK CONSTRAINT [FK_VisitLeson_Lesson]
GO
ALTER TABLE [dbo].[VisitLeson]  WITH CHECK ADD  CONSTRAINT [FK_VisitLeson_Student] FOREIGN KEY([IdStudent])
REFERENCES [dbo].[Student] ([id])
GO
ALTER TABLE [dbo].[VisitLeson] CHECK CONSTRAINT [FK_VisitLeson_Student]
GO
USE [master]
GO
ALTER DATABASE [School1] SET  READ_WRITE 
GO
