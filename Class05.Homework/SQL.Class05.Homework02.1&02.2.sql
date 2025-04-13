--Homework 02.1
--Create new procedure called CreateGrade;
--Procedure should create only Grade header info (not Grade Details);
--Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade);
--Procedure should return second resultset with the MAX Grade of all 
--grades for the Student and Teacher on input (regardless the Course).


CREATE OR ALTER PROCEDURE CreateGrade
(
    @StudentID INT,
    @CourseID INT,
    @TeacherID INT,
    @Grade INT,
    @Comment NVARCHAR(MAX)
)

AS
BEGIN
    INSERT INTO Grade (StudentID, CourseID, TeacherID, Grade, Comment, CreatedDate)
    VALUES (@StudentID, @CourseID, @TeacherID, @Grade, @Comment, GETDATE());

    SELECT COUNT(*) AS TotalGrades
    FROM Grade
    WHERE StudentID = @StudentID;

    SELECT MAX(Grade) AS MaxGrade
    FROM Grade
    WHERE StudentID = @StudentID AND TeacherID = @TeacherID;
END;

EXEC CreateGrade
    @StudentID = 1,
    @CourseID = 2,
    @TeacherID = 3,
    @Grade = 10,
    @Comment = 'nesto';


--Homework 02.2
--Create new procedure called CreateGradeDetail;
--Procedure should add details for specific Grade (new record for new
--AchievementTypeID, Points, MaxPoints, Date for specific Grade);
--Output from this procedure should be resultset with SUM of
--GradePoints calculated with formula
--AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade

CREATE OR ALTER PROCEDURE CreateGradeDetail
(
    @GradeID INT,
    @AchievementTypeID INT,
    @AchievementPoints SMALLINT,
    @AchievementMaxPoints SMALLINT,
    @AchievementDate DATE
)

AS
BEGIN

    INSERT INTO GradeDetails (GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
    VALUES (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate);

    SELECT 
    SUM(CAST(gd.AchievementPoints AS FLOAT) / gd.AchievementMaxPoints * at.ParticipationRate) AS TotalGradePoints
    FROM GradeDetails gd
    JOIN AchievementType at ON gd.AchievementTypeID = at.ID
    WHERE gd.GradeID = @GradeID;
END;

EXEC CreateGradeDetail
    @GradeID = 10,
    @AchievementTypeID = 2,
    @AchievementPoints = 80,
    @AchievementMaxPoints = 90,
    @AchievementDate = '2025-04-13';

