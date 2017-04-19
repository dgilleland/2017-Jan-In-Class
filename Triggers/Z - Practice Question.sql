-- Create a trigger on the Customer table so that when a customer is added,
-- the distributor for that customer will have their wage increased by five cents.
-- You can assume that only one customer will be added at a time (but do a check for a rowcount of 1 anyway....).

CREATE TRIGGER Customer_Distributor_Bonus
ON Customer
FOR INSERT
AS
    IF @@ROWCOUNT = 1
    BEGIN
        UPDATE Distributor
        SET Wage = Wage + 0.05
        WHERE  DistributorID = (SELECT DistributorID
                                FROM Region R1
                                  INNER JOIN [Route] R2
                                    ON R1.RegionID = R2.RegionID
                                  INNER JOIN inserted I
                                    ON I.RouteID = R2.RouteID)
    END
RETURN
GO
