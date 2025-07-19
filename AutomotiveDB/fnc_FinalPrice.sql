CREATE FUNCTION dbo.fn_GetFinalPrice
(
    @DealerCarID INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @BasePrice FLOAT, @DiscountPercent FLOAT, @FeePercent FLOAT, @FinalPrice FLOAT;

    SELECT 
        @BasePrice = dc.Price,
        @DiscountPercent = ISNULL(dc.DiscountPercent, 0),
        @FeePercent = ISNULL(dc.FeePercent, 0)
    FROM DealerCar dc
    WHERE dc.DealerCarID = @DealerCarID;

    SET @FinalPrice = @BasePrice 
                    - (@BasePrice * @DiscountPercent / 100) 
                    + (@BasePrice * @FeePercent / 100);

    RETURN @FinalPrice;
END;


---- Menghitung final price untuk DealerCarID = 2
--SELECT dbo.fn_GetFinalPrice(2) AS FinalPrice;
--SELECT * From DealerCar
--SELECT * From LetterOfIntent
--SELECT * From Agreement

--INSERT INTO LetterOfIntent (DealerCarID, DiscountAmount, FeeAmount, FinalPrice, DownPayment, PaymentMethod) VALUES
--(2, 23320000, 2915000, dbo.fn_GetFinalPrice(2), 40000000, 'credit');