--Joins Exercise 1
USE [A01-School]
GO

--1.	Select Student full names and the course ID's they are registered in.
SELECT  FirstName + ' ' + LastName AS 'Student Name',
        CourseID
FROM    Student
    -- An INNER JOIN means that there has to be matching data on both tables
    INNER JOIN Registration
            ON Student.StudentID = Registration.StudentID
-- If we use aliases for the table names, our code is easier to read
SELECT  FirstName + ' ' + LastName AS 'Student Name',
        CourseID
FROM    Student S
    -- An INNER JOIN means that there has to be matching data on both tables
    INNER JOIN Registration R
            ON S.StudentID = R.StudentID


--1.a. Select Student full names, the course ID and the course name that the students are registered in.
--     (Hint, this involves joining together three tables)
SELECT  FirstName + ' ' + LastName AS 'Student Name',
        C.CourseID,
        CourseName
FROM    Student S
    INNER JOIN Registration R
            ON S.StudentID = R.StudentID
    INNER JOIN Course C
            ON R.CourseId = C.CourseId


--2.	Select the Staff full names and the Course ID’s they teach
SELECT  DISTINCT -- The DISTINCT keyword will remove duplicate rows
        FirstName + ' ' + LastName AS 'Staff Name',
        CourseId
FROM    Staff S
    INNER JOIN Registration R
            ON R.StaffID = S.StaffID
ORDER BY 'Staff Name', CourseId

--3.	Select all the Club ID's and the Student full names that are in them

--4.	Select the Student full name, courseID's and marks for studentID 199899200.
SELECT  S.FirstName + ' ' + S.LastName AS 'Student Name',
        R.CourseId,
        R.Mark
FROM    Registration R
    INNER JOIN Student S
            ON S.StudentID = R.StudentID
WHERE   S.StudentID = 199899200

--5.	Select the Student full name, course names and marks for studentID 199899200.

--6.	Select the CourseID, CourseNames, and the Semesters they have been taught in
SELECT  C.CourseId, CourseName, Semester
FROM    Course C
    INNER JOIN Registration R
            ON C.CourseId = R.CourseId

-- An alternate approach, starting from a different table
SELECT  C.CourseId, CourseName, Semester
FROM    Registration R
    INNER JOIN Course C
            ON C.CourseId = R.CourseId

--7.	What Staff Full Names have taught Networking 1?
-- Brief investigation
SELECT  CourseName FROM Course
-- Answer
SELECT  FirstName + ' ' + LastName AS 'Staff Name'
FROM    Staff S
    INNER JOIN Registration R ON S.StaffID = R.StaffID
    INNER JOIN Course C on R.CourseId = C.CourseId
WHERE   CourseName = 'Networking 1'
-- Because there are duplicate names, it would be good to use DISTINCT
SELECT  DISTINCT FirstName + ' ' + LastName AS 'Staff Name'
FROM    Staff S
    INNER JOIN Registration R ON S.StaffID = R.StaffID
    INNER JOIN Course C on R.CourseId = C.CourseId
WHERE   CourseName = 'Networking 1'

--8.	What is the course list for student ID 199912010 in semester 2001S. Select the Students Full Name and the Course Names

--9. What are the Student Names, courseID's that have Marks >80?

--10. Create two questions to get data from the database where each question needs at least two tables for the result. You have to make up the question, code the solution, and check that it's right.
