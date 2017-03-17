-- Stored Procedures with validation and testing
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

-- 1. Create a stored procedure called AddPosition that will accept a Position Description (varchar 50). Return the primary key value that was database-generated as a result of your Insert statement. Also, ensure that the supplied description is not NULL and that it is at least 5 characters long. Make sure that you do not allow a duplicate position name.


-- 2) Create a stored procedure called LookupClubMembers that takes a club ID and returns the full names of all members in the club.

-- 3) Create a stored procedure called RemoveClubMembership that takes a club ID and deletes all the members of that club. Be sure that the club exists. Also, raise an error if there were no members deleted from the club.

-- 4) Create a stored procedure called OverActiveMembers that takes a single number: ClubCount. This procedure should return the names of all members that are active in as many or more clubs than the supplied club count.
--    (p.s. - You might want to make sure to add more members to more clubs, seeing as tests for the last question might remove a lot of club members....)
-- STUDENT ANSWER HERE --


-- 5) Create a stored procedure called ListStudentsWithoutClubs that lists the full names of all students who are not active in a club.
-- STUDENT ANSWER HERE --


-- 6) Create a stored procedure called LookupStudent that accepts a partial student last name and returns a list of all students whose last name includes the partial last name. Return the student first and last name as well as their ID.
-- STUDENT ANSWER HERE --

