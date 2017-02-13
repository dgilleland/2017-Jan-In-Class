--SIMPLE SELECT EXERCISE 1
--USE THE A01-School DATABASE 
use [A01-School]
GO


--1.  Select all the information from the club table
SELECT  ClubId, ClubName
FROM    Club

--2. Select the FirstNames and LastNames of all the students
SELECT  FirstName, LastName
FROM    Student

--3. Select all the CourseId and CourseName of all the coureses. Use the column aliases of Course ID and Course Name
SELECT  CourseId AS 'Course ID', CourseName AS 'Course Name'
FROM    Course

--4. Select all the course information for courseID 'DMIT101'
SELECT CourseID, CourseName, CourseHours, MaxStudents, CourseCost
FROM   Course
WHERE  CourseID = 'DMIT101'

--5. Select the Staff names who have positionID of 3
SELECT  S.FirstName, S.LastName
       --,S.PositionID
FROM    Staff S -- S is acting as an alias for the Staff table in this query
WHERE   S.PositionID = 3
--   BTW, what is PositionID of 3 refering to??
SELECT  P.PositionDescription
FROM    Position P
WHERE   P.PositionID = 3

--6. select the CourseNames whose CourseHours are less than 96
SELECT  C.CourseName --, C.CourseHours
FROM    Course C     -- C is a Table alias
WHERE   C.CourseHours < 96

--7. Select the studentID's, CourseID and mark where the Mark is between 70 and 80
SELECT  R.StudentID, R.CourseId, R.Mark
FROM    Registration R
--WHERE   R.Mark >= 70 AND R.Mark <= 80
WHERE   R.Mark BETWEEN 70 AND 80 -- BETWEEN is inclusive

--7.a Select the student IDs where the withdrawal status is null
SELECT  StudentID--, WithdrawYN
FROM    Registration
WHERE   WithdrawYN IS NULL -- we use IS NUL instead of = NULL
-- It's not necessary that the result returns rows for it to be correct.

-- 7.b Select the studentIDs of students who have withdrawn from a course
SELECT  StudentID
FROM    Registration
WHERE   WithdrawYN = 'Y'

--8. Select the studentID's, CourseID and mark where the Mark is between 70 and 80 and the courseID is DMIT223 or DMIT168
/*
INSERT INTO Registration(CourseId, Mark, Semester, StaffID, StudentID)
VALUES ('DMIT223', 40, '2000S', 5, 199899200)
*/
SELECT  R.StudentID, R.CourseId, R.Mark
FROM    Registration R
WHERE   R.Mark BETWEEN 70 AND 80
  AND   (R.CourseId = 'DMIT223' OR R.CourseId = 'DMIT168')
-- alternate answer to #8
SELECT  R.StudentID, R.CourseId, R.Mark
FROM    Registration R
WHERE   R.Mark BETWEEN 70 AND 80
  AND   R.CourseId IN ('DMIT223', 'DMIT168')

--8.a Select the studentIDs, CourseID and mark where the Mark is 80 and 85
SELECT  R.StudentID, R.CourseId, R.Mark
FROM    Registration R
WHERE   R.Mark = 80 OR R.Mark = 85
--WHERE   R.Mark IN (80, 85)

-- Pattern matching searches often use the LIKE comparison along with
-- wildcards.
    -- % is a wildcard for 0 or more characters
    -- _ is a wildcard for a single character
    -- Square brackets are used to identify a single character that
    --  fits a range or is one of the set
        -- [1-9] means any digit from 1 to 9, but not zero
        -- '[BN]ob' would match for either 'Bob' or 'Nob'
--9. Select the students first and last names who have last names starting with S
SELECT  S.FirstName, S.LastName
FROM    Student S
WHERE   S.LastName LIKE 'S%' 

--10. Select Coursenames whose CourseID  has a 1 as the fifth character
SELECT CourseName --, CourseID
FROM   Course
WHERE  CourseId LIKE '____1%' -- four underscores, 1, %
--                    DMIT158


--11. Select the CourseID's and Coursenames where the CourseName contains the word 'programming'

--12. Select all the ClubNames who start with N or C.

--13. Select Student Names, Street Address and City where the lastName has only 3 letters long.

--14. Select all the StudentID's where the PaymentAmount < 500 OR the PaymentTypeID is 5



