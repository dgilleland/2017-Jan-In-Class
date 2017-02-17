--Simple Select Exercise 2
-- This set of exercises demonstrates performing simple Aggregate funcction
-- to get results such as SUM(), AVG(), COUNT()
-- All aggregates are done using built-in functions in the database

USE [A01-School]
GO

--1.    Select the average Mark from all the marks in the Registration table
SELECT  AVG(Mark) AS 'Average Mark' -- I am using an alias for the column name's output
FROM    Registration

--2.    Select the average Mark of all the students who are taking DMIT104
SELECT  AVG(Mark) AS 'Average Mark'
FROM    Registration
WHERE   CourseID = 'DMIT104'

--3. Select how many students there are in the Student table
SELECT  COUNT(*) as 'Student Count' -- the * means "All columns"
FROM    Student

--4. Select how many students have taken (i.e. - have a grade for) DMIT152
SELECT  COUNT(Mark) AS 'Student Count for DMIT152'
FROM    Registration
WHERE   CourseId = 'DMIT152'

--5. Select the average payment amount for payment type 5
SELECT  AVG(Amount) AS 'Average Payment Amount'
FROM    Payment
WHERE   PaymentTypeID = 5

-- Given that there are some other aggregate methods like MAX(columnName) and MIN(columnName), complete the following two questions:
--6. Select the highest payment amount
SELECT MAX(Amount) AS 'Highest Payment Amount'
FROM   Payment

--7. Select the lowest payment amount
SELECT MIN(Amount) AS 'Lowest Payment Amount'
FROM   Payment

-- For the following question, what table will we need to query to get the total?
--8. Select the total of all the payments that have been made
SELECT SUM(Amount) AS 'Sum of Payments'
FROM   Payment

-- For the following question, what aggregate method would you use and what table would you query?
--9. How many different payment types does the school accept?
SELECT COUNT(PaymentTypeID)
FROM   PaymentType

--9.a. How many payments have been made for each payment type
SELECT COUNT(*) AS 'Number of payments for this payment type', PaymentTypeID
FROM   Payment
GROUP BY PaymentTypeID

--10. How many students are in club 'CSS'?
-- STUDENT ANSWER HERE