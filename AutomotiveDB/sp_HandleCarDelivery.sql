CREATE PROCEDURE sp_HandleCarDelivery
    @AgreementID INT = 0,
    @CarID INT = 0,
    @DealerID INT = 0,
    @WarrantyPeriodMonths INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validasi: AgreementID harus ada
        IF NOT EXISTS (SELECT 1 FROM Agreement WHERE ID = @AgreementID)
        BEGIN
            RAISERROR('AgreementID cannot be found. Please create Agreement first.', 16, 1);
            RETURN;
        END

        -- Validasi: Warranty untuk Agreement ini belum dibuat
        IF EXISTS (SELECT 1 FROM WarrantyRegistration WHERE PurchaseID = @AgreementID)
        BEGIN
            RAISERROR('Warranty for this transaction already exists.', 16, 1);
            RETURN;
        END

        -- Insert WarrantyRegistration
        INSERT INTO WarrantyRegistration (CarID, PurchaseID, WarrantyPeriodMonths)
        VALUES (@CarID, @AgreementID, @WarrantyPeriodMonths);

        PRINT 'The handover of the car was successful. You also receive a warranty for the car that has been purchased.';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred during the handover process.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO



--    ---- create LOI first
--    INSERT INTO LetterOfIntent (DealerCarID, Discount, FixPrice, DownPayment, BookingFee, PaymentMethod) VALUES

--(3, 10000000, 252000000, 35000000, 2000000, 'credit');

    ---- create agreement first
--    INSERT INTO Agreement (CustomerID, SalesPersonID, LoiID) VALUES
--(1, 2, 4);

--select * from LetterOfIntent
--select * from Agreement

--EXEC sp_HandleCarDelivery 
--    @AgreementID = 5,
--    @CarID = 2,
--    @DealerID = 2,
--    @WarrantyPeriodMonths = 24;

--    select * from WarrantyRegistration