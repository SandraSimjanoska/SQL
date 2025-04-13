	--HOMEWORK CLASS03
--Declare scalar variable for storing FirstName values
DECLARE @FirstName NVARCHAR(50);

--Assign value ‘Antonio’ to the FirstName variable
SET @FirstName = 'Antonio';

--Find all Students having FirstName same as the variable
SELECT *
FROM Student
WHERE FirstName = @FirstName;

--Declare table variable that will contain StudentId, StudentName and DateOfBirth
DECLARE @FemaleStudents TABLE (
StudentID INT,
StudentName NVARCHAR(100),
DateOfBirth DATE
);

--Fill the table variable with all Female students
INSERT INTO @FemaleStudents (StudentID, StudentName, DateOfBirth)
SELECT ID,
CONCAT(FirstName, ' ', LastName),
DateOfBirth
FROM Student
WHERE Gender = 'F';

SELECT * FROM @FemaleStudents

-- Declare temp table that will contain LastName and EnrolledDate columns
DROP TABLE #MaleStudents;
CREATE TABLE #MaleStudents (FirstName NVARCHAR(50), LastName NVARCHAR(50), EnrolledDate DATE);

-- Fill the temp table with all Male students having First Name starting with ‘A’
INSERT INTO #MaleStudents (FirstName, EnrolledDate)
SELECT FirstName,EnrolledDate
FROM Student
WHERE Gender = 'Male' AND FirstName LIKE 'A%';



-- Retrieve the students from the table which last name is with 7 characters
SELECT *
FROM #MaleStudents
WHERE LEN(LastName) = 7;

--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName and LastName are the same
SELECT *
FROM Teacher
WHERE LEN(FirstName) < 5 AND LEFT(FirstName, 3) = LEFT(LastName, 3);
