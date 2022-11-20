USE [School]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 20.11.2022 23:59:00 ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 20.11.2022 23:59:01 ******/
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
/****** Object:  Table [dbo].[JobTitle]    Script Date: 20.11.2022 23:59:01 ******/
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
/****** Object:  Table [dbo].[Lesson]    Script Date: 20.11.2022 23:59:01 ******/
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
/****** Object:  Table [dbo].[LessonEmployee]    Script Date: 20.11.2022 23:59:01 ******/
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
/****** Object:  Table [dbo].[Schedule]    Script Date: 20.11.2022 23:59:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NumberCabinet] [int] NOT NULL,
	[idLessonEmloyee] [int] NOT NULL,
	[DataTimeStart] [time](7) NOT NULL,
	[DataTimeFinich] [time](7) NOT NULL,
	[idWeek] [int] NOT NULL,
	[Activ] [bit] NOT NULL,
 CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 20.11.2022 23:59:01 ******/
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
/****** Object:  Table [dbo].[StudentLesson]    Script Date: 20.11.2022 23:59:01 ******/
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
/****** Object:  Table [dbo].[VisitLeson]    Script Date: 20.11.2022 23:59:01 ******/
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
/****** Object:  Table [dbo].[Week]    Script Date: 20.11.2022 23:59:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Week](
	[id] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Week] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
