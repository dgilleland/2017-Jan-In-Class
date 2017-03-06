/*  SubQuery Exercise 1  */
-- Each question must use a subquery in its solution.
--**If the questions could also be solved without a subquery, solve it without one as well**

USE [A01-School]
GO

--1. Select the Payment dates and payment amount for all payments that were Cash
-- I'm going to break down the problem in a step-by-step
-- a) What payment type is 'Cash'?
SELECT PaymentTypeID --, PaymentTypeDescription
FROM   PaymentType
WHERE  PaymentTypeDescription = 'cash'
--    I discover that the PaymentTypeID is 1
-- b) Getting payment dates and amounts for cash payments (using the ID)
SELECT  PaymentDate, Amount
FROM    Payment
WHERE   PaymentTypeID = 1

-- c) I can get the answer from b) by using a subquery that asks for 'cash' information
SELECT  PaymentDate, Amount
FROM    Payment
WHERE   PaymentTypeID = 
        (SELECT PaymentTypeID
         FROM   PaymentType
         WHERE  PaymentTypeDescription = 'cash')

-- Here is the Inner Join version of the above
SELECT PaymentDate, Amount 
FROM Payment P
    INNER JOIN PaymentType PT
        ON PT.PaymentTypeID = P.PaymentTypeID 
WHERE PaymentTypeDescription = 'cash'


--2. Select The Student ID's of all the students that are in the 'Association of Computing Machinery' club
-- TODO: Student Answer Here

--3. Select All the staff full names that have taught a course.
-- Notice how a subquery always returns a single COLUMN, but it may return zero or many ROWS
-- Again, using a step-by-step approach
-- a) Find all the IDs of staff that have taught a course
SELECT DISTINCT StaffID FROM Registration
-- b) Names of these staff members (using subquery)
SELECT FirstName + ' ' + LastName AS 'Staff'
FROM   Staff
WHERE  StaffID IN (SELECT DISTINCT StaffID FROM Registration)

-- The above can also be done as an INNER JOIN...
SELECT DISTINCT FirstName + ' ' + LastName AS 'Staff'
FROM Staff
    INNER JOIN Registration
        ON Staff.StaffID = Registration.StaffID

--4. Select All the staff full names that taught DMIT172.
-- TODO: Student Answer Here (answer is Jerry Kan)


--5. Select All the staff full names that have never taught a course
SELECT FirstName + ' ' + LastName AS 'Staff'
FROM   Staff
WHERE  StaffID NOT IN -- I used IN because the subquery returns many rows
       (SELECT DISTINCT StaffID FROM Registration)

-- To do the above question with a JOIN requires that we use an OUTER JOIN...
SELECT FirstName + ' ' + LastName 'Staff'
      --, Registration.StaffID
FROM Staff 
    LEFT OUTER JOIN Registration
        ON Staff.StaffID =Registration.StaffID
WHERE Registration.StaffID IS NULL

--6. Select the Payment TypeID(s) that have the highest number of Payments made.
-- Explore the counts of payment types, before you try the subquery
-- a) Let's just look at all the data from the Payment table (which is the central table that has the data we need for this question)
SELECT  *
FROM    Payment

-- b) What would the count of payment types IDs look like?
SELECT  PaymentTypeID, COUNT(PaymentTypeID)
FROM    Payment
GROUP BY PaymentTypeID
      -- Note: I see that the highest count of payments is 7

-- c) Start looking at how to filter the results of my query.
SELECT  PaymentTypeID --, COUNT(PaymentTypeID)
FROM    Payment
GROUP BY PaymentTypeID
HAVING  COUNT(PaymentTypeID) = 7

-- d) Use a subquery to get the counts of the groups, and apply that to my HAVING clause
SELECT  PaymentTypeID
FROM    Payment
GROUP BY PaymentTypeID
HAVING  COUNT(PaymentTypeID) >=  ALL(SELECT COUNT(PaymentTypeID)
                                     FROM Payment
                                     GROUP BY PaymentTypeID)

--7. Select the Payment Type Description(s) that have the highest number of Payments made.
SELECT PaymentTypeDescription
FROM   Payment 
    INNER JOIN PaymentType 
        ON Payment.PaymentTypeID = PaymentType.PaymentTypeID
GROUP BY PaymentType.PaymentTypeID, PaymentTypeDescription 
HAVING COUNT(PaymentType.PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
                                                FROM Payment 
                                                GROUP BY PaymentTypeID)

--8. What is the total avg mark for the students from Edm?
SELECT AVG(Mark) AS 'Average'
FROM   Registration 
WHERE  StudentID IN (SELECT StudentID FROM Student WHERE City = 'Edm')

-- The above results, done as a JOIN instead of a subquery
SELECT AVG(Mark) AS 'Average'
FROM   Registration 
    INNER JOIN Student
        ON Registration.StudentID = Student.StudentID
WHERE City = 'Edm'

--9. What is the avg mark for each of the students from Edm? Display their StudentID and avg(mark)
-- TODO: Student Answer Here.....

