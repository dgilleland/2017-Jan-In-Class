/* Stored Procedures

-- Unlike dropping and creating tables, it's completely safe to drop and re-create
-- stored procedures (no data will be lost or harmed in the process).
-- The following is a good template for checking if a stored procedure (SPROC) exists
-- before dropping it. It is followed by the template for creating a stored procedure.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SprocName')
    DROP PROCEDURE SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO


-- Besides being able to drop and create stored procedures, we can modify/alter an
-- existing stored procedure by using the ALTER keyword.

ALTER PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO


-- To actually execute (run) the stored procedure, you call EXEC
EXEC SprocName ValuesForParameters
-- where the ValuesForParameters is a comma-separated list of zero or more values (one for each parameter in the sproc).
*/
USE [A01-School]
GO

-- Simple Stored Procedure Exercises

-- 1. Create a stored procedure called ListAllCourses that will select all the columns in the Course table to return all the courses in the database

-- 2. Create a stored procedure called LookupCourse that accepts a single value (name the parameter @CourseID) and returns the course with the supplied ID. Return all the columns.

-- 3. Create a stored procedure called AddCourse that will insert a course into the database. Include parameters for all the columns in the Course table. No validation is required.

-- 4. Create a stored procedure called UpdateCourse that will modify the contents of a course. Include parameters for all the columns in the Course table. No validation is required.

-- 5. Create a stored procedure called RemoveCourse that will delete a course from the database. The procedure must accept a single value (@CourseID). No validation is required.

-- 6. Create stored procedures to perform CRUD options similar to the ones above, but designed to support the Student table. Call the stored procedures ListAllStudents, LookupStudent, AddStudent, UpdateStudent, and RemoveStudent. Be sure to use appropriate parameters for all stored procedures. No validation is required.
-- STUDENT ANSWER HERE --
