-- Insert/Update/Delete Examples

USE [A01-SCHOOL]
GO

-- Insert Examples
--  The first part of the INSERT statement identifies where we are putting the data.
--  The second half of the INSERT statement identifies the data itself

-- 1. Let's add a new course called "Expert SQL". It will be a 90 hour course with a cost of $450.00
INSERT INTO Course(CourseId, CourseName, CourseHours, CourseCost)
    VALUES        ('DMIT777', 'Expert SQL', 90      , 450.00)
GO

-- 2. Let's add a new staff member, someone who's really good at SQL
-- SELECT * FROM Staff
-- SELECT * FROM Position
INSERT INTO Staff(FirstName, LastName, DateHired, PositionID)
    SELECT        'Dan',   'Gilleland', GETDATE(), PositionID
    FROM    Position
    WHERE   PositionDescription = 'Instructor'

-- 2b. Let's get another instructor
INSERT INTO Staff(FirstName, LastName, DateHired, PositionID)
    VALUES ('Shane', 'Bell', GETDATE(),
            (SELECT PositionID
             FROM   Position
             WHERE  PositionDescription = 'Instructor')
           )

-- 3. There are three additional clubs being started at the school:
--      - START - Small Tech And Research Teams
--      - CALM - Coping And Lifestyle Management
--      - RACE - Rapid Acronym Creation Experts
INSERT INTO Club(ClubId, ClubName)
    VALUES ('START', 'Small Tech and Research Teams'),
           ('CALM', 'Coping And Lifestyle Management'),
           ('RACE', 'Rapid Acronym Creation Experts')

-- 4. Add yourself and another person to the Student table (use fake information for your address)
--    The BalanceOwing portion should be $1500.00

-- 5. Join the START club. (That is, add yourself to the club by inserting a row of data into the Activity table.)

-- 6. Pay off the money you owe the school. Insert the appropriate data into the Payment table to pay by cash (you will find the money under your seat in the next class today).


-- -----------------------------------------------------------------
-- Update Examples
--  The UPDATE statement consists of three clauses:
--      - UPDATE clause - where you identify the TableName
--      - SET    clause - a comma-separated list of assignments of values into columns
--      - WHERE  clause - a filter to choose which rows to modify

-- 1. The school thinks it can get a bit more money out of students
--    because of the popularity of a few of its courses. As such,
--    they are increasing the course cost of 'Expert SQL' and 'Quality Assurance'
--    by 10%.
UPDATE Course
SET    CourseCost = CourseCost * 1.10 
WHERE  CourseName IN ('Expert SQL', 'Quality Assurance')
-- You should see 2 rows affected


-- 2. Along with the goals of the school to make more money, they are allowing
--    all courses to have a total of 10 students as the maximum.
--  SELECT * FROM Course
UPDATE Course
SET    MaxStudents = 10
-- Notice that because we don't have a WHERE clause, ALL of the rows will be affected.

-- 3. One of the students has moved and has supplied their new address.
--    Change the address of student 199912010 to 4407-78 Ave, Edmonton, T4Y3P0
UPDATE Student
SET    StreetAddress = '4407-78 Ave',
       City = 'Edmonton',
       PostalCode = 'T4Y3P0'
WHERE  StudentID = 199912010

-- 4. Someone in the registrar's office has noticed a bunch of data-entry errors.
--    All the student cities named 'Edm' should be changed to 'Edmonton'
UPDATE Student
SET    City = 'Edmonton'
WHERE  City = 'Edm'


-- 5. HEY! I recall that you paid your BalanceOwing in the INSERT exercises, but the Student table was never updated. Modify the Student table to change your BalanceOwing to zero.

-- 6. Shane Bell has been promoted to the Assistant Dean position. Update his PositionID accordingly.

-- ---------------------------------------------------
-- Delete Examples
--  The DELETE statement has two clauses:
--      - DELETE FROM   - Identifies the database table from which you want to remove rows of data
--      - WHERE         - A filter to say which rows you want to affect
--                          REMEMBER BOBBY TABLES !!!!!

-- 1. A scandal has rocked the CSS club. The president has run off with all the club's money.
--    As such, the club is disbanded. Remove all the members of the CSS club.
-- SELECT * FROM Activity ORDER BY ClubID
DELETE FROM Activity
WHERE  ClubID = 'CSS'

-- 2. Remove yourself from all clubs. You are about to get really, really busy.......

----------------------------------------
-- Mixed exercises.

-- 1. You have been accepted into an experimental Educational Alternatives program where you and two other friends can enroll in up to five courses together for the upcoming term.
    --  Add yourself to five second-year courses (e.g. - DMIT235) by inserting data into the Registration table. The semester should be for the upcoming semester (YYYYM) (e.g. - 2017M). Assign whatever instructor(s) you wish to these courses.
    --  One of your instructors just got enrolled in the CSIS witness protection program. Update the Registration table accordingly to assign his course(s) to someone else, and delete the instructor from the Staff table.
    --  It's the end of the term. Update the registration for the courses you joined by giving yourself an appropriate mark. (Be honest...)

