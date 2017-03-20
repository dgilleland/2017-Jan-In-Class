-- More Simple Stored Procedures
USE [A01-School]
GO

 --1. Create a stored procedure called AddClub that will add a new club to the database. (No validation is required).
 IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'AddClub')
    DROP PROCEDURE AddClub
GO
CREATE PROCEDURE AddClub
    -- Parameters here
    @ClubId     varchar(10),
    @ClubName   varchar(50)
AS
    -- Body of procedure here
    -- Should put some validation here.....

    INSERT INTO Club(ClubId, ClubName)
    VALUES (@ClubId, @ClubName)
RETURN
GO

 --2. Create a stored procedure that will change the mailing address for a student. Call it ChangeMailingAddress.
 --   Make sure all the parameter values are supplied before running the UPDATE (ie: no NULLs).
CREATE PROCEDURE ChangeMailingAddress
    -- Parameters here
    @StudentId  int,
    @Street     varchar(35), -- Model the type/size of parameters to match what's needed in the database tables
    @City       varchar(30),
    @Province   char(2),
    @PostalCode char(6)
AS
    -- Body of procedure here
    -- Validate
    IF (@StudentId IS NULL OR @Street IS NULL OR @City IS NULL OR @Province IS NULL OR @PostalCode IS NULL)
    BEGIN --    { A...
        RAISERROR('All parameters require a value (NULL is not accepted)', 16, 1)
    END   -- ...A }
    ELSE
    BEGIN
        UPDATE  Student
        SET     StreetAddress = @Street
               ,City = @City
               ,Province = @Province
               ,PostalCode = @PostalCode
        WHERE   StudentID = @StudentId
    END
RETURN
GO

-- 3. Create a stored procedure that will remove a student from a club. Call it RemoveFromClub. Ensure that the supplied Student ID is not null.
-- STUDENT ANSWER HERE --

-- Query Stored Procedures
-- 4. Create a stored procedure that will display all the staff and their position in the school.
--    Show the full name of the staff member and the description of their position.
-- STUDENT ANSWER HERE --

-- 5. Display all the final course marks for a given student. Include the name and number of the course
--    along with the student's mark.
-- STUDENT ANSWER HERE --

-- 6. Display the students that are enrolled in a given course on a given semester.
--    Display the course name and the student's full name and mark.
-- STUDENT ANSWER HERE --

-- 7. The school is running out of money! Find out who still owes money for the courses they are enrolled in.
-- STUDENT ANSWER HERE --
