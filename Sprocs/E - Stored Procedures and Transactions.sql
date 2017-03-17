-- Stored Procedures and Transactions
USE [A01-School]
GO

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


-- 1. Add a stored procedure called TransferCourse that accepts a student ID, semester, and two course IDs: the one to move the student out of and the one to move the student in to.


-- 2. Add a stored procedure called AdjustMarks that takes in a course ID. The procedure should adjusts the marks of all students for that course by increasing the mark by 10%. Be sure that nobody gets a mark over 100%.



-- 3. Create a stored procedure called RegisterStudent that accepts StudentID, CourseID and Semester as parameters. If the number of students in that course and semester are not greater than the Max Students for that course, add a record to the Grade table and add the cost of the course to the students balance. If the registration would cause the course in that semester to have greater than MaxStudents for that course raise an error.



-- 4. Add a stored procedure called WitnessProtection that erases all existence of a student from the database. The stored procedure takes the StudentID, first and last names, gender, and birthdate as parameters. Ensure that the student exists in the database before removing them (all the parameter values must match).


-- 5. Create a procedure called StudentPayment that accepts Student ID and paymentamount as parameters. Add the payment to the payment table and adjust the students balance owing to reflect the payment.


-- 6. Create a stored procedure called WithdrawStudent that accepts a StudentID, CourseId, and semester as parameters. Withdraw the student by updating their Withdrawn value to 'Y' and subtract 1/2 of the cost of the course from their balance. If the result would be a negative balance set it to 0.

-- 7. Create a stored procedure called ArchiveStudentGrades that will accept a year and will archive all grade records from that year from the grade table to an ArchiveGrade table. Copy all the appropriate records from the grade table to the ArchiveGrade table and delete them from the grade table. The ArchiveGrade table will have the same definition as the grade table but will not have any constraints.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ArchiveGrade')
    DROP TABLE ArchiveGrade

CREATE TABLE ArchiveGrade
(
	StudentID		int,
	CourseId		char (7),
	Semester		char (5),
	Mark			decimal(5,2),
	WithdrawYN		char (1),
	StaffID			smallint
)
GO
