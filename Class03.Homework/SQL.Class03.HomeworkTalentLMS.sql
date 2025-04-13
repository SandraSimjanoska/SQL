--HOMEWORK CLASS02 from talentlms

--Calculate the count of all grades per Teacher in the system
SELECT TeacherID,
COUNT(*) AS GradeCount
FROM Grade
GROUP BY TeacherID;

--Calculate the count of all grades per Teacher in the system for first 100Students (ID < 100)
SELECT g.TeacherID,
COUNT(*) AS GradeCount
FROM Grade g
JOIN Student s ON G.StudentID = s.ID
WHERE s.ID < 100
GROUP BY g.TeacherID;

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT StudentID,
MAX(Grade) AS MaxGrade,
AVG(Grade) AS AvgGrade
FROM Grade
GROUP BY StudentID;


--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
SELECT TeacherID,
COUNT(*) AS GradeCount
FROM Grade
GROUP BY TeacherID
HAVING COUNT(*) > 200;

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. 
--Filter only records where Maximal Grade is equal to Average Grade

SELECT StudentID,
COUNT(*) AS GradeCount,
MAX(Grade) AS MaxGrade,
AVG(Grade) AS AvgGrade
FROM Grade
GROUP BY StudentID
HAVING MAX(Grade) = AVG(Grade);

--List Student First Name and Last Name next to the other details from previous query
SELECT s.FirstName, s.LastName, g.GradeCount,g.MaxGrade, g.AvgGrade
FROM ( SELECT StudentID,
       COUNT(*) AS GradeCount,
       MAX(Grade) AS MaxGrade,
       AVG(Grade) AS AvgGrade
    FROM Grade
    GROUP BY StudentID
    HAVING MAX(Grade) = AVG(Grade)
) g
JOIN Student s ON g.StudentID = s.ID;

--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
CREATE OR ALTER VIEW vv_StudentGrades AS
SELECT StudentID,
COUNT(*) AS GradeCount
FROM Grade
GROUP BY StudentID;

SELECT * FROM vv_StudentGrades

--Change the view to show Student First and Last Names instead of StudentID
CREATE OR ALTER  VIEW vv_StudentGrades
AS
SELECT s.FirstName, s.LastName,
COUNT(*) AS GradeCount
FROM Grade g
JOIN Student s ON g.StudentID = s.ID
GROUP BY s.FirstName, s.LastName;

--List all rows from view ordered by biggest Grade Count
SELECT *
FROM vv_StudentGrades
ORDER BY GradeCount DESC;