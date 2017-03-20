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
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ListAllCourses')
    DROP PROCEDURE ListAllCourses
GO
CREATE PROCEDURE ListAllCourses
    -- Parameters here
AS
    -- Body of procedure here
    SELECT  CourseId, CourseName, CourseHours, MaxStudents, CourseCost
    FROM    Course
RETURN
GO
-- The CREATE PROCEDURE statement simply *creates* the procedure; it does not execute it (i.e., call it).
-- To call the stored procedure, we use the EXEC statement
EXEC ListAllCourses

-- 2. Create a stored procedure called LookupCourse that accepts a single value (name the parameter @CourseID) and returns the course with the supplied ID. Return all the columns.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'LookupCourse')
    DROP PROCEDURE LookupCourse
GO
CREATE PROCEDURE LookupCourse
    -- Parameters here - Each parameter is a "variable" and starts with @
    @CourseID   char(7)
AS
    -- Body of procedure here
    SELECT  CourseId, CourseName, CourseHours, MaxStudents, CourseCost
    FROM    Course
    WHERE   CourseId = @CourseID
RETURN
GO

-- Call the stored procedure to lookup 'DMIT108'
EXEC LookupCourse 'DMIT108'
GO
-- 3. Create a stored procedure called AddCourse that will insert a course into the database. Include parameters for all the columns in the Course table. No validation is required.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'AddCourse')
    DROP PROCEDURE AddCourse
GO
CREATE PROCEDURE AddCourse
    -- Parameters here
    @CourseID               char(7)     ,
    @Name                   varchar(40) ,
    @Hours                  smallint    ,
    @MaxNumberOfStudents    int         ,
    @CourseCost             decimal
AS
    -- Body of procedure here
    INSERT INTO Course(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
    VALUES (@CourseID, @Name, @Hours, @MaxNumberOfStudents, @CourseCost)
RETURN
GO

EXEC AddCourse 'DMIT294', 'Advanced Web Development', 60, 24, 450.00
GO

-- 4. Create a stored procedure called UpdateCourse that will modify the contents of a course. Include parameters for all the columns in the Course table. No validation is required.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'UpdateCourse')
    DROP PROCEDURE UpdateCourse
GO
CREATE PROCEDURE UpdateCourse
    -- Parameters here
    @ID             char(7)     ,
    @Name           varchar(40) ,
    @CourseHours    smallint    ,
    @MaxNoStudents  int         ,
    @Cost           decimal
AS
    -- Body of procedure here
    UPDATE  Course
    SET     CourseName = @Name          ,
            CourseHours = @CourseHours  ,
            MaxStudents = @MaxNoStudents,
            CourseCost = @Cost
    WHERE   CourseId = @ID
RETURN
GO

EXEC UpdateCourse 'DMIT294', 'Very Advanced Web Dev', 90, 20, 775.00
GO
-- 5. Create a stored procedure called RemoveCourse that will delete a course from the database. The procedure must accept a single value (@CourseID). No validation is required.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'RemoveCourse')
    DROP PROCEDURE RemoveCourse
GO
CREATE PROCEDURE RemoveCourse
    -- Parameters here
    @CourseId       char(7)
AS
    -- Body of procedure here
    DELETE Course
    WHERE  CourseId = @CourseId
RETURN
GO

EXEC RemoveCourse 'DMIT294'
GO

-- 6. Create stored procedures to perform CRUD options similar to the ones above, but designed to support the Student table. Call the stored procedures ListAllStudents, LookupStudent, AddStudent, UpdateStudent, and RemoveStudent. Be sure to use appropriate parameters for all stored procedures. No validation is required.
-- STUDENT ANSWER HERE --
