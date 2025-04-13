--Find all Students with FirstName = Antonio
SELECT *
FROM Student
WHERE FirstName = 'Antonio';

--Find all Students with DateOfBirth greater than ‘01.01.1999’
SELECT *
FROM Student
WHERE DateOfBirth > '1999-01-01';

--Find all Students with LastName starting With ‘J’ enrolled in January/1998
SELECT *
FROM Student
WHERE LastName LIKE 'J%' 

--List all Students ordered by FirstName
SELECT *
FROM Student
ORDER BY FirstName;

--List all Teacher Last Names and Student Last Names in single result set.
--Remove duplicates
SELECT DISTINCT LastName
FROM (
    SELECT LastName FROM Student
    UNION
    SELECT LastName FROM Teacher
) AS CombinedLastNames;

--Create Foreign key constraints from diagram or with script
ALTER TABLE Grade
ADD CONSTRAINT FK_Grade_Student
FOREIGN KEY (StudentID) REFERENCES Student(ID);

ALTER TABLE Grade
ADD CONSTRAINT FK_Grade_Teacher
FOREIGN KEY (TeacherID) REFERENCES Teacher(ID);

ALTER TABLE Grade
ADD CONSTRAINT FK_Grade_Course
FOREIGN KEY (CourseID) REFERENCES Course(ID);

ALTER TABLE GradeDetails
ADD CONSTRAINT FK_GradeDetails_Grade
FOREIGN KEY (GradeID) REFERENCES Grade(ID);

ALTER TABLE GradeDetails
ADD CONSTRAINT FK_GradeDetails_AchievementType
FOREIGN KEY (AchievementTypeID) REFERENCES AchievementType(ID);

--List all possible combinations of Courses names and AchievementType
--names that can be passed by student
SELECT c.Name AS CourseName, a.Name AS AchievementType
FROM Course c
CROSS JOIN AchievementType a;

--List all Teachers without exam Grade
SELECT *
FROM Teacher
WHERE ID NOT IN (
    SELECT DISTINCT TeacherID
    FROM Grade
);