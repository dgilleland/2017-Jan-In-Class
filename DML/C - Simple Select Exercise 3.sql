--Simple Select Exercise 3
-- This sample set illustrates the GROUP BY syntax and the use of Aggregate functions with GROUP BY.
-- It also demonstrates the HAVING clause to filter a group of statements
USE [A01-School]
GO

SELECT  CourseID
FROM    Registration
GROUP BY CourseID
--ORDER BY CourseID

--1. Select the average mark for each course. Display the CourseID and the average mark
SELECT  CourseID,                   -- This column is a non-Aggregate
        AVG(Mark) AS 'Average Mark' -- This column performs Aggregation (to produce 1 value)
FROM    Registration
GROUP BY CourseId
-- When performing an Aggregate function in the SELECT clause, if you have any other
-- non-Aggregate columns in the SELECT clause, then these must be listed in the GROUP BY clause.

--2. How many payments were made for each payment type. Display the Payment typeID and the count
SELECT PaymentTypeID,
       COUNT(PaymentTypeID) AS 'Count of Pay Type'
FROM   Payment
GROUP BY PaymentTypeID

--3. Select the average Mark for each studentID. Display the StudentId and their average mark
SELECT StudentID,
       AVG(Mark) AS 'Avg Mark'
FROM   Registration
GROUP BY StudentID

--4. Select the same data as question 3 but only show the studentID's and averages that are > 80
SELECT StudentID,
       AVG(Mark) AS 'Avg Mark'
FROM   Registration
GROUP BY StudentID
-- The HAVING clause is where we do filtering of Aggregate information
HAVING AVG(Mark) > 80

--5. How many students are from each city? Display the City and the count.
SELECT City,
       COUNT(StudentID) AS 'Student Count'
FROM   Student
GROUP BY City

--6. Which cities have 2 or more students from them? (HINT, remember that fields that we use in the where or having do not need to be selected.....)
SELECT City
--       ,COUNT(StudentID) AS 'Student Count'
FROM   Student
GROUP BY City
HAVING COUNT(StudentID) >= 2

--7. What is the highest, lowest and average payment amount for each payment type? 
SELECT MAX(Amount) AS 'Highest',
       MIN(Amount) AS 'Lowest',
       AVG(Amount) AS 'Average'
FROM   Payment
GROUP BY PaymentTypeID

--8. How many students are there in each club? Show the clubID and the count

--9. Which clubs have 3 or more students in them?


