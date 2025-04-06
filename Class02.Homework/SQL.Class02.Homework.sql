CREATE DATABASE SEDC_ACADEMY_HOMEWORK;

USE SEDC_ACADEMY_HOMEWORK

CREATE TABLE [Student] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [FirstName] NVARCHAR(100) NULL,
    [LastName] NVARCHAR(100) NULL,
    [DateOfBirth] DATE NULL,
    [EnrolledDate] DATE NULL,
    [Gender] NCHAR(1) NULL,
    [NationalIdNumber] BIGINT NULL,
    [StudentCardNumber] NVARCHAR(100) NULL
);

CREATE TABLE [Teacher] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [FirstName] NVARCHAR(100) NULL,
    [LastName] NVARCHAR(100) NULL,
    [DateOfBirth] DATE NULL,
    [AcademicRank] NVARCHAR(100) NULL,
    [HireDate] DATE NULL
);


CREATE TABLE [Course] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(MAX) NULL,
    [Credit] TINYINT NULL,
    [AcademicYear] TINYINT NULL,
    [Semester] TINYINT NULL
);

CREATE TABLE [Grade] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [StudentID] INT NULL,
    [CourseID] INT NULL,
    [TeacherID] INT NULL,
    [Grade] TINYINT NULL,
    [Comment] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME NULL,
    FOREIGN KEY ([StudentID]) REFERENCES [Student]([ID]),
    FOREIGN KEY ([CourseID]) REFERENCES [Course]([ID]),
    FOREIGN KEY ([TeacherID]) REFERENCES [Teacher]([ID])
);

CREATE TABLE [AchievementType] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(150) NULL,
    [Description] NVARCHAR(MAX) NULL,
    [ParticipationRate] INT NULL
);

CREATE TABLE [GradeDetails] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [GradeID] INT NULL,
    [AchievementTypeID] INT NULL,
    [AchievementPoints] SMALLINT NULL,
    [AchievementMaxPoints] SMALLINT NULL,
    [AchievementDate] DATE NULL,
    FOREIGN KEY ([GradeID]) REFERENCES [Grade]([ID]),
    FOREIGN KEY ([AchievementTypeID]) REFERENCES [AchievementType]([ID])
);

