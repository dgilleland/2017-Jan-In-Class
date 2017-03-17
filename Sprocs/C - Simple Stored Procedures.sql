-- Stored Procedures with simple validation
USE [A01-School]
GO

--**Stored Procedure has to be the first statement in a batch so place GO in between each question to execute the previous batch (question) and start another. **
/*
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SprocName')
    DROP PROCEDURE SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO
*/

--1.	Create a stored procedure called “HonorCourses” to select all the course names that have averages >80%.

--2.	Create a stored procedure called “HonorCoursesOneTerm” to select all the course names that have average >80% in semester 2004J.

--3.	Oops, made a mistake! For question 2, it should have been for semester 2004S. Write the code to change the procedure accordingly. 

--3.B. Your instructor is back, and recommends that the previous stored procedure use a parameter for the semester, making it more "re-usable"

/*
-- Now the stored procedure can be called with any semester I want
EXEC HonorCoursesOneTerm '2004S'
EXEC HonorCoursesOneTerm '2004J'
*/

--4.B.	Create a stored procedure called “NotInCourse” that lists the full names of the students that are not in a particular course. The stored procedure should expect the course number as a parameter. e.g.: DMIT221.

--5.	Create a stored procedure called “LowNumbers” to select the course name of the course(s) that have had the lowest number of students in it.


--6.	Create a stored procedure called “Provinces” to list all the students provinces.
-- STUDENT ANSWER HERE --

--7.	OK, question 6 was ridiculously simple and serves no purpose. Lets remove that stored procedure from the database.
-- STUDENT ANSWER HERE --

--8.	Create a stored procedure called StudentPaymentTypes that lists all the student names and their payment types. Ensure all the student names are listed.
-- STUDENT ANSWER HERE --

--9.	Modify the procedure from question 8 to return only the student names that have made payments.
-- STUDENT ANSWER HERE --



