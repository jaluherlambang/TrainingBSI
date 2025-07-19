CREATE FUNCTION dbo.fn_GetDiscountAmount
(
    @DealerCarID INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @BasePrice FLOAT, @DiscountPercent FLOAT, @DiscountAmount FLOAT;

    SELECT 
        @BasePrice = dc.Price,
        @DiscountPercent = ISNULL(dc.DiscountPercent, 0)
    FROM DealerCar dc
    WHERE dc.DealerCarID = @DealerCarID;

    SET @DiscountAmount = @BasePrice * @DiscountPercent / 100;

    RETURN @DiscountAmount;
END;

--SELECT dbo.fn_GetDiscountAmount(2) AS DiscountAmount;
--SELECT * From DealerCar
--SELECT * From LetterOfIntent
--SELECT * From Agreement

--INSERT INTO LetterOfIntent (DealerCarID, DiscountAmount, FeeAmount, FinalPrice, DownPayment, PaymentMethod) VALUES
--(2, dbo.fn_GetDiscountAmount(2), 2915000, dbo.fn_GetFinalPrice(2), 40000000, 'credit');