-- Triggers Samples
USE [A01-School]
GO

/*
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Table_TriggerName]'))
    DROP TRIGGER Table_TriggerName
GO

CREATE TRIGGER Table_TriggerName
ON TableName
FOR Insert, Update, Delete -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
RETURN
GO
*/
-- Making a diagnostic trigger for the first example
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Activity_DML_Diagnostic]'))
    DROP TRIGGER Activity_DML_Diagnostic
GO

CREATE TRIGGER Activity_DML_Diagnostic  -- Name of trigger
ON Activity                             -- Name of table
FOR Insert, Update, Delete -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
    SELECT 'Activity Table:', StudentID, ClubId FROM Activity ORDER BY StudentID
    SELECT 'Inserted Table:', StudentID, ClubId FROM inserted ORDER BY StudentID
    SELECT 'Deleted Table:', StudentID, ClubId FROM deleted ORDER BY StudentID
RETURN
GO

-- Demonstrate the diagnostic trigger
INSERT INTO Activity(StudentID, ClubId) VALUES (200494476, 'CIPS')
UPDATE Activity SET ClubId = 'NASA1' WHERE StudentID = 200494476
DELETE FROM Activity WHERE StudentID = 200494476

GO
-- Disable a trigger
DISABLE TRIGGER Activity_DML_Diagnostic ON Activity


-- 1. The Education Board is concerned with rising course costs! Create a trigger to ensure that a course cost does not get increased by more than 20% at any one time.
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Course_Update_CourseCostLimit]'))
    DROP TRIGGER Course_Update_CourseCostLimit
GO

CREATE TRIGGER Course_Update_CourseCostLimit
ON Course
FOR Update -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
    IF @@ROWCOUNT > 0 AND
       EXISTS(SELECT * FROM inserted I 
              INNER JOIN deleted D ON I.CourseId = D.CourseId
              WHERE I.CourseCost > D.CourseCost * 1.20) -- 20% higher
    BEGIN
        RAISERROR('Students can''t afford that much of an increase!', 16, 1)
        ROLLBACK TRANSACTION
    END
RETURN
GO
-- Investigations - What's the current course costs
SELECT CourseId, CourseCost FROM Course

UPDATE Course
SET  CourseCost = 1000

-- 2. The school has placed a temporary hold on the creation of any more clubs. (Existing clubs can be renamed or removed, but no additional clubs can be created.) Put a trigger on the Clubs table to prevent any new clubs from being created.
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Club_Insert_Lockdown]'))
    DROP TRIGGER Club_Insert_Lockdown
GO

CREATE TRIGGER Club_Insert_Lockdown
ON Club
FOR Insert -- Choose only the DML statement(s) that apply
AS
	-- Body of Trigger
    IF @@ROWCOUNT > 0
    BEGIN
        RAISERROR('Temporary lockdown on creating new clubs.', 16, 1)
        ROLLBACK TRANSACTION
    END
RETURN
GO

-- Create some statement(s) to test this trigger. Make sure it doesn't block doing an UPDATE or DELETE (it should only run for an INSERT).

-- 3. In order to be fair to all students, a student can only belong to a maximum of 3 clubs. Create a trigger to enforce this rule.
-- a) See who is in a club and how many clubs they are in...
SELECT  S.StudentID, FirstName, LastName, COUNT(ClubId) AS 'Number of clubs'
FROM    Student S INNER JOIN Activity A ON S.StudentID = A.StudentID
GROUP BY S.StudentID, FirstName, LastName
ORDER BY 'Number of clubs' DESC

-- b) Based on the information from the above query, I get the following:
/*
199912010	Dave	Brown	3
200495500	Robert	Smith	3
200322620	Flying	Nun 	2
199899200	Ivy	    Kent	1
200312345	Mary	Jane	1
*/
--    So now I can expect that adding Dave Brown (199912010) to a new club, my trigger should reject that
--    (i.e.: perform a ROLLBACK TRANSACTION)

-- c) I can plan for joining the *inserted* and *Activity* tables (joining on matching the StudentIDs)
--    in order to count the number of clubs, and then see if any of them HAVE more than 3 clubs
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Activity_MaxClubMemberships]'))
    DROP TRIGGER Activity_MaxClubMemberships
GO

CREATE TRIGGER Activity_MaxClubMemberships
ON Activity
FOR Insert, Update
AS
    -- Body of Trigger
    IF @@ROWCOUNT > 0 AND
       EXISTS(SELECT COUNT(A.ClubID) FROM Activity A
              INNER JOIN inserted i ON A.StudentID = i.StudentID
              GROUP BY i.StudentID HAVING COUNT(A.ClubID) > 3)
    BEGIN
        RAISERROR('Max of 3 clubs that a student can belong to', 16, 1)
        ROLLBACK TRANSACTION
    END
RETURN
GO

-- d) Test my trigger to make sure it works
-- SELECT * FROM Club
INSERT INTO Activity(StudentID, ClubID)
VALUES (199912010, 'CHESS')
-- Clean up from earlier mistakes (in case data actually gets inserted):
-- DELETE FROM Activity WHERE StudentID = 199912010 AND ClubID = 'CHESS'
-- Here's a few more tests to see if this works correctly
INSERT INTO Activity(StudentID, ClubID)
VALUES (200322620, 'CALM') -- This row, by itself, should be acceptable
      ,(200495500, 'CALM') -- This row causes the whole batch to fail


-- 4. Too many students owe us money and keep registering for more courses! Create a trigger to ensure that a student cannot register for any more courses if they have a balance owing of more than $500.
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Registration_InsertUpdate_BalanceOwing]'))
    DROP TRIGGER Registration_InsertUpdate_BalanceOwing
GO

CREATE TRIGGER Registration_InsertUpdate_BalanceOwing
ON Registration
FOR Insert, Update -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
    IF @@ROWCOUNT > 0 AND
       EXISTS(SELECT * FROM inserted I INNER JOIN  Student S ON I.StudentID = S.StudentID
              WHERE S.BalanceOwing > 500)
    BEGIN
        RAISERROR('Student owes too much money - cannot register student in course', 16, 1)
        ROLLBACK TRANSACTION
    END
RETURN
GO

-- TODO: Student, write code to test this trigger

-- 5. Our school DBA has suddenly disabled some Foreign Key constraints to deal with performance issues! Create a trigger on the Registration table to ensure that only valid CourseIDs, StudentIDs and StaffIDs are used for grade records. (You can use sp_help tablename to find the name of the foreign key constraints you need to disable to test your trigger.) Have the trigger raise an error for each foreign key that is not valid. If you have trouble with this question create the trigger so it just checks for a valid student ID.
-- sp_help Registration -- then disable the foreign key constraints....
ALTER TABLE Registration NOCHECK CONSTRAINT FK_GRD_CRS_CseID
ALTER TABLE Registration NOCHECK CONSTRAINT FK_GRD_STF_StaID
ALTER TABLE Registration NOCHECK CONSTRAINT FK_GRD_STU_StuID
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Registration_InsertUpdate_EnforceForeignKeyValues]'))
    DROP TRIGGER Registration_InsertUpdate_EnforceForeignKeyValues
GO

CREATE TRIGGER Registration_InsertUpdate_EnforceForeignKeyValues
ON Registration
FOR Insert,Update -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
    IF @@ROWCOUNT > 0
    BEGIN
        -- UPDATE(columnName) is a function call that checks to see if information between the 
        -- deleted and inserted tables for that column are different (i.e.: data in that column
        -- has changed).
        IF UPDATE(StudentID) -- If the data in the StudentID column has changed
           AND
           NOT EXISTS (SELECT * FROM inserted I INNER JOIN Student S ON I.StudentID = S.StudentID)
        BEGIN
            RAISERROR('That is not a valid StudentID', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        IF UPDATE(CourseID) AND
           NOT EXISTS (SELECT * FROM inserted I INNER JOIN Course C ON I.CourseId = C.CourseId)
        BEGIN
            RAISERROR('That is not a valid CourseID', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        IF UPDATE(StaffID) AND
           NOT EXISTS (SELECT * FROM inserted I INNER JOIN Staff S ON I.StaffID = S.StaffID)
        BEGIN
            RAISERROR('That is not a valid StaffID', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
RETURN
GO
-- TODO: Test the trigger to make sure it works
-- 6. Our network security officer suspects our system has a virus that is allowing students to alter their balance owing records! In order to track down what is happening we want to create a logging table that will log any changes to the balance owing in the Student table. You must create the logging table and the trigger to populate it when the balance owing is modified.
-- Step 1) Make the logging table
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BalanceOwingLog')
    DROP TABLE BalanceOwingLog
GO
CREATE TABLE BalanceOwingLog
(
    LogID           int  IDENTITY (1,1) NOT NULL CONSTRAINT PK_BalanceOwingLog PRIMARY KEY,
    ChangeDateTime  datetime            NOT NULL, -- When the change has occurred
    StudentID       int                 NOT NULL, -- Which student is affected
    OldBalance      decimal (7,2)       NOT NULL, -- "Before" balance
    NewBalance      decimal (7,2)       NOT NULL  -- "After" balance
)
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Student_Update_AuditBalanceOwing]'))
    DROP TRIGGER Student_Update_AuditBalanceOwing
GO

CREATE TRIGGER Student_Update_AuditBalanceOwing
ON Student
FOR Update -- Choose only the DML statement(s) that apply
AS
	-- Body of Trigger
    IF @@ROWCOUNT > 0 AND UPDATE(BalanceOwing)
	BEGIN
	    INSERT INTO BalanceOwingLog (ChangedateTime, StudentID, OldBalance, NewBalance)
	    SELECT GETDATE(), D.StudentID, D.BalanceOwing, I.BalanceOwing
        FROM deleted D INNER JOIN inserted I on D.StudentID = I.StudentID
	    IF @@ERROR <>0 
	    BEGIN
		    RAISERROR('Insert into BalanceOwingLog Failed',16,1)
            ROLLBACK TRANSACTION
		END	
	END
RETURN
GO

-- Test the audit trigger....
SELECT BalanceOwing FROM Student WHERE StudentID = 199899200
SELECT * FROM BalanceOwingLog

-- Set up some test data.....
    UPDATE Student
    SET    BalanceOwing = BalanceOwing + 550
    WHERE  StudentID = 199899200

-- Here comes the hackers! First, the student himself.....
UPDATE Student
SET BalanceOwing = 1
WHERE StudentID = 199899200
-- Hacker student brags to friends, who give him some drinks, and the next thing you know, they've got the code...
UPDATE Student
SET BalanceOwing = 1
