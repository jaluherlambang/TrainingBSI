CREATE FUNCTION dbo.fn_GetFeeAmount
(
    @DealerCarID INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @BasePrice FLOAT, @FeePercent FLOAT, @FeeAmount FLOAT;

    SELECT 
        @BasePrice = dc.Price,
        @FeePercent = ISNULL(dc.FeePercent, 0)
    FROM DealerCar dc
    WHERE dc.DealerCarID = @DealerCarID;

    SET @FeeAmount = @BasePrice * @FeePercent / 100;

    RETURN @FeeAmount;
END;

---- Menghitung final price untuk DealerCarID = 2
--SELECT dbo.fn_GetFeeAmount(2) AS FinalPrice;
--SELECT * From DealerCar
--SELECT * From LetterOfIntent
--SELECT * From Agreement

--INSERT INTO LetterOfIntent (DealerCarID, DiscountAmount, FeeAmount, FinalPrice, DownPayment, PaymentMethod) VALUES
--(2, 23320000, dbo.fn_GetFeeAmount(2), dbo.fn_GetFinalPrice(2), 40000000, 'credit');