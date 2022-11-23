USE [master]
GO
/****** Object:  Database [ScLR]    Script Date: 22.11.2022 21:13:03 ******/
CREATE DATABASE [ScLR]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ScLR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ScLR.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ScLR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ScLR_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ScLR] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ScLR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ScLR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ScLR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ScLR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ScLR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ScLR] SET ARITHABORT OFF 
GO
ALTER DATABASE [ScLR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ScLR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ScLR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ScLR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ScLR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ScLR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ScLR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ScLR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ScLR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ScLR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ScLR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ScLR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ScLR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ScLR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ScLR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ScLR] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ScLR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ScLR] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ScLR] SET  MULTI_USER 
GO
ALTER DATABASE [ScLR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ScLR] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ScLR] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ScLR] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ScLR] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ScLR] SET QUERY_STORE = OFF
GO
USE [ScLR]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 22.11.2022 21:13:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 22.11.2022 21:13:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobTitle]    Script Date: 22.11.2022 21:13:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson]    Script Date: 22.11.2022 21:13:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LessonEmployee]    Script Date: 22.11.2022 21:13:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 22.11.2022 21:13:03 ******/
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
	[Activ] [bit] NOT NULL,
 CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 22.11.2022 21:13:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentLesson]    Script Date: 22.11.2022 21:13:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisitLeson]    Script Date: 22.11.2022 21:13:03 ******/
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
	[TimeStart] [nvarchar](50) NOT NULL,
	[TimeFinish] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_VisitLeson] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (1, N'1 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (2, N'2 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (3, N'3 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (4, N'4 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (5, N'5 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (6, N'6 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (7, N'7 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (8, N'8 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (9, N'9 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (10, N'10 класс', 1)
INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (11, N'11 класс', 1)
SET IDENTITY_INSERT [dbo].[Class] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (3, 2, N'Егор', N'Николаев', N'Занидаидович', 232001, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (4, 2, N'Абдула', N'Куриков', N'Жинкович', 232002, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (5, 2, N'Аида', N'Иванова', N'Аркадьевна', 232003, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (6, 2, N'Аделина', N'Безрукова', N'Олеговна', 232004, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (7, 2, N'Ксения', N'Виноградова', N'Игоревна', 232005, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (8, 2, N'Вероника', N'Березина', N'Антоновна', 232006, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (9, 2, N'Лидия', N'Высоцкая', N'Максимовна', 232007, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (10, 2, N'Лаура', N'Иванова', N'Аркадьевна', 232008, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (11, 2, N'Аксинья', N'Денисова', N'Денисовна', 232009, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (12, 2, N'Глория', N'Калугина', N'Александровна', 232010, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (13, 2, N'Дамир', N'Зайдуллин', N'Матвеевич', 232011, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (14, 2, N'Динар', N'Гатауллин', N'Александрович', 232012, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (15, 2, N'Амир', N'Хамзин', N'Филиппович', 232013, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (16, 2, N'Линар', N'Козлов', N'Валентинович', 232014, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (17, 2, N'Далер', N'Егоров', N'Андреевич', 232015, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (18, 2, N'Матвей', N'Матвеев', N'Васильевич', 232016, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (19, 2, N'Максим', N'Иванов ', N'Андреевич', 232017, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (20, 2, N'Григорий', N'Глебов', N'Бедросович', 232018, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (21, 2, N'Дмитрий', N'Захаров', N'Ильич', 232019, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (22, 2, N'Никита', N'Павлов', N'Ильич', 232020, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (23, 1, N'Андрей', N'Петров', N'Петрович', 232021, 123, 1)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[JobTitle] ON 

INSERT [dbo].[JobTitle] ([id], [Name]) VALUES (1, N'Администратор')
INSERT [dbo].[JobTitle] ([id], [Name]) VALUES (2, N'Преподаватель')
SET IDENTITY_INSERT [dbo].[JobTitle] OFF
GO
SET IDENTITY_INSERT [dbo].[Lesson] ON 

INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (1, N'Латиница', 0, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (2, N'Древнегреческий', 0, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (3, N'Юкагирский', 6, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (4, N'Чукотский', 6, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (5, N'Ненцкий', 6, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (6, N'Карельский', 5, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (7, N'Фризский', 5, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (8, N'Баскский', 5, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (9, N'Галийский', 10, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (10, N'Ирландский', 10, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (11, N'Вепсский', 10, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (12, N'Идиш', 8, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (13, N'Нивхский', 8, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (14, N'Кетский', 8, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (15, N'Бретонский', 7, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (16, N'Кашубский', 7, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (17, N'Ижорский', 7, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (18, N'Водский', 5, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (19, N'Ливский', 5, 1)
INSERT [dbo].[Lesson] ([id], [Name], [MaximumNumberOfStudents], [Active]) VALUES (20, N'Западный манси', 8, 1)
SET IDENTITY_INSERT [dbo].[Lesson] OFF
GO
SET IDENTITY_INSERT [dbo].[LessonEmployee] ON 

INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (1, 1, 3)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (2, 2, 3)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (3, 1, 4)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (4, 2, 4)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (5, 3, 5)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (6, 4, 6)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (7, 5, 7)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (8, 6, 8)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (9, 7, 9)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (10, 2, 10)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (11, 9, 11)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (12, 6, 12)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (13, 3, 7)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (14, 4, 10)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (15, 5, 6)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (16, 10, 8)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (17, 11, 13)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (18, 12, 13)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (19, 13, 14)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (20, 14, 15)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (21, 15, 16)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (22, 16, 17)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (23, 17, 18)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (24, 18, 19)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (25, 19, 20)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (26, 20, 21)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (27, 11, 22)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (28, 12, 21)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (29, 13, 19)
SET IDENTITY_INSERT [dbo].[LessonEmployee] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (3, 101, 1, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (7, 102, 3, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (10, 101, 2, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (11, 101, 4, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (12, 103, 4, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (13, 103, 5, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (14, 103, 5, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (16, 104, 6, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (18, 105, 7, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (19, 106, 7, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (20, 106, 7, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (21, 107, 7, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (22, 107, 8, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (23, 108, 9, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (24, 109, 10, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (25, 109, 11, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (26, 110, 12, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (27, 201, 13, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (29, 202, 14, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (30, 202, 15, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (31, 203, 16, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (32, 204, 17, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (33, 205, 18, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (34, 206, 19, CAST(N'10:50:00' AS Time), CAST(N'11:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (35, 207, 20, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (1, 1, N'Дмитрий', N'Куриков', N'Михайлович', 10001, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (2, 1, N'Гений', N'Хурмин', N'Уголкович', 10002, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (3, 2, N'Ада', N'Иванова', N'Александровна ', 10003, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (4, 2, N'Арслан', N'Федоров', N'Антонович', 10004, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (5, 2, N'Аделина', N'Безрукова', N'Аркадьевна', 10005, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (6, 3, N'Андрей', N'Смирнов', N'Антонович', 10006, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (7, 3, N'Аделия', N'Иванова', N'Виталиевна', 10007, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (8, 3, N'Айдар', N'Смирнов', N'Антонович', 10008, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (9, 3, N'Аза', N'Белова', N'Игоревна', 10009, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (10, 4, N'Анвар', N'Алексеев', N'Ильич', 10010, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (11, 4, N'Азалия', N'Березина', N'Иосифна', 10011, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (12, 4, N'Антон', N'Семенов', N'Евгеньевич', 10012, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (13, 4, N'Аида', N'Васильева', N'Леонидовна', 10013, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (14, 5, N'Дамир', N'Егоров', N'Денисович', 10014, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (15, 5, N'Лия', N'Винокурова', N'Федоровна', 10015, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (16, 5, N'Динар', N'Павлов', N'Владимирович', 10016, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (17, 6, N'Лора', N'Виноградова', N'Филипповна', 10017, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (18, 6, N'Денис', N'Козлов', N'Борисович', 10018, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (19, 6, N'Луиза', N'Иванова', N'Эдуардовна', 10019, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (20, 7, N'Евсей', N'Никитин', N'Андреевич', 10020, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (21, 7, N'Лукерья', N'Второва', N'Эдуардовна', 10021, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (22, 7, N'Игнат', N'Орлов', N'Валентинович', 10022, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (23, 8, N'Любовь', N'Высоцкая', N'Леонидовна', 10023, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (24, 8, N'Макар', N'Андреев', N'Васильевич', 10024, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (25, 8, N'Магдалина', N'Глебова', N'Максимовна', 10025, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (26, 9, N'Олег', N'Захаров', N'Бедросович', 10026, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (27, 9, N'Майя', N'Глухова', N'Матвеевна', 10027, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (28, 9, N'Олег', N'Дмитриев', N'Константинович', 10028, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (29, 9, N'Малика', N'Глушкова', N'Максимовна', 10029, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (30, 10, N'Тимур', N'Королев', N'Феликсович', 10030, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (31, 10, N'Мальвина', N'Горячева', N'Львовна', 10031, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (32, 10, N'Савва', N'Гусев', N'Филиппович', 10032, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (33, 10, N'Марианна', N'Дорохова', N'Ефимовна', 10033, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (34, 10, N'Савелий', N'Баранов', N'Семенович', 10034, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (35, 10, N'Мара', N'Дорофеева', N'Егоровна', 10035, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (36, 11, N'Святослав', N'Беляев', N'Станиславович', 10036, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (37, 11, N'Тала', N'Иванова', N'Олеговна', 10037, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (38, 11, N'Вячеслав', N'Герасимов', N'Платонович', 10038, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (39, 11, N'Тамара', N'Дроздова', N'Ефимовна', 10039, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (40, 11, N'Эльдар', N'Беляев', N'Александрович', 10040, N'123', 1)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentLesson] ON 

INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (3, 1, 2)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (5, 1, 1)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (6, 1, 3)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (7, 1, 4)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (8, 2, 1)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (9, 2, 5)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (10, 2, 6)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (11, 2, 7)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (12, 3, 1)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (13, 3, 8)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (14, 3, 9)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (15, 3, 10)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (16, 4, 5)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (17, 4, 11)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (18, 4, 12)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (19, 4, 13)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (20, 5, 14)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (21, 5, 2)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (22, 5, 15)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (23, 5, 16)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (24, 6, 17)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (25, 6, 11)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (26, 6, 18)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (27, 6, 19)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (28, 7, 20)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (29, 7, 21)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (30, 7, 22)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (31, 7, 23)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (32, 8, 17)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (33, 8, 20)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (34, 8, 14)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (35, 8, 24)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (36, 9, 21)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (37, 9, 25)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (38, 9, 26)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (39, 9, 27)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (40, 10, 28)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (41, 10, 29)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (42, 10, 30)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (43, 10, 31)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (44, 11, 32)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (45, 11, 33)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (46, 11, 34)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (47, 11, 35)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (48, 12, 4)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (49, 12, 36)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (50, 12, 37)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (51, 12, 38)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (52, 13, 39)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (53, 13, 30)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (54, 13, 31)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (55, 13, 13)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (56, 14, 33)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (57, 14, 32)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (58, 14, 12)
SET IDENTITY_INSERT [dbo].[StudentLesson] OFF
GO
SET IDENTITY_INSERT [dbo].[VisitLeson] ON 

INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (7, 1, 1, CAST(N'2022-11-22' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (8, 1, 1, CAST(N'2022-11-21' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (9, 1, 1, CAST(N'2022-11-20' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (10, 1, 2, CAST(N'2022-11-20' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (11, 1, 2, CAST(N'2022-11-21' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (12, 1, 2, CAST(N'2022-11-22' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (13, 1, 3, CAST(N'2022-11-20' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (14, 1, 4, CAST(N'2022-11-20' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (15, 1, 4, CAST(N'2022-11-21' AS Date), 1, 3, N'9:00:00', N'9:45:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (16, 2, 1, CAST(N'2022-11-20' AS Date), 1, 9, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (17, 2, 1, CAST(N'2022-11-19' AS Date), 1, 9, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (18, 2, 1, CAST(N'2022-11-18' AS Date), 1, 10, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (19, 2, 5, CAST(N'2022-11-18' AS Date), 1, 10, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (20, 2, 5, CAST(N'2022-11-19' AS Date), 1, 9, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (21, 2, 6, CAST(N'2022-11-18' AS Date), 1, 10, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (22, 2, 6, CAST(N'2022-11-19' AS Date), 1, 9, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (23, 2, 7, CAST(N'2022-11-20' AS Date), 1, 9, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (24, 2, 7, CAST(N'2022-11-19' AS Date), 1, 9, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (25, 2, 7, CAST(N'2022-11-18' AS Date), 1, 9, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (26, 6, 1, CAST(N'2022-11-22' AS Date), 1, 8, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (27, 6, 1, CAST(N'2022-11-21' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (28, 6, 1, CAST(N'2022-11-20' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (29, 6, 1, CAST(N'2022-11-19' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (30, 6, 1, CAST(N'2022-11-18' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (31, 6, 8, CAST(N'2022-11-22' AS Date), 1, 8, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (32, 6, 8, CAST(N'2022-11-21' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (33, 6, 8, CAST(N'2022-11-20' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (34, 6, 8, CAST(N'2022-11-19' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (35, 6, 9, CAST(N'2022-11-18' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (36, 6, 10, CAST(N'2022-11-18' AS Date), 1, 12, N'9:50:00', N'10:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (37, 13, 39, CAST(N'2022-11-15' AS Date), 1, 19, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (38, 13, 30, CAST(N'2022-11-16' AS Date), 1, 19, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (39, 13, 31, CAST(N'2022-11-17' AS Date), 1, 19, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (40, 13, 39, CAST(N'2022-11-15' AS Date), 1, 19, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (41, 13, 30, CAST(N'2022-11-16' AS Date), 1, 19, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (42, 13, 31, CAST(N'2022-11-17' AS Date), 1, 19, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (43, 14, 33, CAST(N'2022-11-10' AS Date), 1, 15, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (44, 14, 32, CAST(N'2022-11-14' AS Date), 1, 15, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (45, 14, 12, CAST(N'2022-11-16' AS Date), 1, 15, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (46, 14, 33, CAST(N'2022-11-10' AS Date), 1, 15, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (47, 14, 32, CAST(N'2022-11-14' AS Date), 1, 15, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (48, 14, 12, CAST(N'2022-11-16' AS Date), 1, 15, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (49, 14, 33, CAST(N'2022-11-10' AS Date), 1, 15, N'10:50:00', N'11:35:00')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (50, 14, 32, CAST(N'2022-11-14' AS Date), 1, 15, N'10:50:00', N'11:35:00')
SET IDENTITY_INSERT [dbo].[VisitLeson] OFF
GO
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
ALTER DATABASE [ScLR] SET  READ_WRITE 
GO
