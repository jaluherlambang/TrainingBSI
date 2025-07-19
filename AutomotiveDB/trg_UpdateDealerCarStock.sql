IF EXISTS (
    SELECT * 
    FROM sys.triggers 
    WHERE name = N'tr_UpdateStockAfterAgreement'
)
    DROP TRIGGER tr_UpdateStockAfterAgreement;
GO

CREATE TRIGGER tr_UpdateStockAfterAgreement
ON Agreement
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE DealerCar
    SET Stock = Stock - 1
    FROM DealerCar dc
    JOIN LetterOfIntent loi ON loi.DealerCarID = dc.DealerCarID
    JOIN inserted i ON i.LoiID = loi.LoiID;

    PRINT 'Dealer Car stock has been reduced automatically.';
END;
GO


---- addd customer dummy
--INSERT INTO Customer (Name, CardID, Address, PhoneNumber, Email)
--VALUES ('Nyeeee', 'BK9837945', 'Jl. Kebayoran 8 no.104, Bekasi', '08130234289', 'Nyeenya3@gmail.com');

---- Tambahkan sales person dummy
--INSERT INTO SalesPerson (Name, DealerID, PhoneNumber, Email)
--VALUES ('Nurul', 2, '088992203427', 'Nurulsales@gmail.com');

---- Tambahkan Letter of Intent (LOI) dummy
--INSERT INTO LetterOfIntent (DealerCarID, DiscountAmount, FeeAmount, FinalPrice, DownPayment, PaymentMethod)
--VALUES (3, dbo.fn_GetDiscountAmount(3), dbo.fn_GetFeeAmount(3), dbo.fn_GetFinalPrice(3), 30000000, 'cash');

------------
--INSERT INTO Agreement (CustomerID, SalesPersonID, LoiID)
--VALUES (4, 4, 8);

--SELECT DealerCarID, Stock 
--FROM DealerCar 

