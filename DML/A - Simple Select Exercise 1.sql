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
FROM    Course C
WHERE   C.CourseHours < 96

--7. Select the studentID's, CourseID and mark where the Mark is between 70 and 80


--8. Select the studentID's, CourseID and mark where the Mark is between 70 and 80 and the courseID is DMIT223 or DMIT168

--9. Select the students first and last names who have last names starting with S

--10. Select Coursenames whose CourseID  have a 1 as the fifth character

--11. Select the CourseID's and Coursenames where the CourseName contains the word 'programming'

--12. Select all the ClubNames who start with N or C.

--13. Select Student Names, Street Address and City where the lastName has only 3 letters long.

--14. Select all the StudentID's where the PaymentAmount < 500 OR the PaymentTypeID is 5



