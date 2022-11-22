USE [School]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 22.11.2022 19:23:26 ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 22.11.2022 19:23:26 ******/
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
/****** Object:  Table [dbo].[JobTitle]    Script Date: 22.11.2022 19:23:26 ******/
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
/****** Object:  Table [dbo].[Lesson]    Script Date: 22.11.2022 19:23:26 ******/
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
/****** Object:  Table [dbo].[LessonEmployee]    Script Date: 22.11.2022 19:23:26 ******/
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
/****** Object:  Table [dbo].[Schedule]    Script Date: 22.11.2022 19:23:26 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 22.11.2022 19:23:26 ******/
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
/****** Object:  Table [dbo].[StudentLesson]    Script Date: 22.11.2022 19:23:26 ******/
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
/****** Object:  Table [dbo].[VisitLeson]    Script Date: 22.11.2022 19:23:26 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([id], [Name], [Activ]) VALUES (1, N'1 класс', 1)
SET IDENTITY_INSERT [dbo].[Class] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (3, 2, N'Егор', N'Николаев', N'Занидаидович', 232001, 123, 1)
INSERT [dbo].[Employee] ([id], [IdJobTitle], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (4, 2, N'Абдула', N'Куриков', N'Жинкович', 232002, 123, 1)
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
SET IDENTITY_INSERT [dbo].[Lesson] OFF
GO
SET IDENTITY_INSERT [dbo].[LessonEmployee] ON 

INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (1, 1, 3)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (2, 2, 3)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (3, 1, 4)
INSERT [dbo].[LessonEmployee] ([id], [IdLesson], [IdEmployees]) VALUES (4, 2, 4)
SET IDENTITY_INSERT [dbo].[LessonEmployee] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (3, 101, 1, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (7, 102, 3, CAST(N'09:00:00' AS Time), CAST(N'09:45:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (10, 101, 2, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
INSERT [dbo].[Schedule] ([id], [NumberCabinet], [idLessonEmloyee], [DataTimeStart], [DataTimeFinich], [Activ]) VALUES (11, 101, 4, CAST(N'09:50:00' AS Time), CAST(N'10:35:00' AS Time), 1)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (1, 1, N'Дмитрий', N'Куриков', N'Михайлович', 10001, N'123', 1)
INSERT [dbo].[Student] ([id], [IdClass], [Name], [Surname], [Lastname], [Login], [Password], [Activ]) VALUES (2, 1, N'Гений', N'Хурмин', N'Уголкович', 10002, N'123', 1)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentLesson] ON 

INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (3, 2, 2)
INSERT [dbo].[StudentLesson] ([id], [IdLesson], [IdStudent]) VALUES (5, 1, 1)
SET IDENTITY_INSERT [dbo].[StudentLesson] OFF
GO
SET IDENTITY_INSERT [dbo].[VisitLeson] ON 

INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (7, 1, 1, CAST(N'2022-11-22' AS Date), 1, 4, N'09:00', N'09:45')
INSERT [dbo].[VisitLeson] ([id], [IdLesson], [IdStudent], [DateVisitLessons], [Presence], [IdTeacher], [TimeStart], [TimeFinish]) VALUES (8, 2, 2, CAST(N'2022-11-22' AS Date), 1, 4, N'09:50', N'10:35')
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
