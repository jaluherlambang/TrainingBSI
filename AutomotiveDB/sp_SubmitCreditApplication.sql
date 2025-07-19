CREATE PROCEDURE sp_SubmitCreditApplication
    @AgreementID INT,
    @CreditAmount FLOAT,
    @Tenor INT,
    @InterestRate FLOAT,
    @MonthlyPaymentAmount FLOAT,
    @CreditStatus VARCHAR(20),
    @PaidFully BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validasi: pastikan AgreementID ada di tabel Agreement
        IF NOT EXISTS (SELECT 1 FROM Agreement WHERE AgreementID = @AgreementID)
        BEGIN
            RAISERROR('AgreementID cannot found. Please create Agreement first.', 16, 1);
            RETURN;
        END

        -- Validasi: pastikan AgreementID belum ada di tabel Credit (karena UNIQUE)
        IF EXISTS (SELECT 1 FROM Credit WHERE AgreementID = @AgreementID)
        BEGIN
            RAISERROR('The credit application has been exist.', 16, 1);
            RETURN;
        END

        -- Insert data kredit
        INSERT INTO Credit (AgreementID,CreditAmount,Tenor,InterestRate,MonthlyPaymentAmount,CreditStatus,PaidFully)
        VALUES (@AgreementID, @CreditAmount,@Tenor,@InterestRate,@MonthlyPaymentAmount,@CreditStatus,@PaidFully
        );

        PRINT 'Credit application has been saved.';
    END TRY
    BEGIN CATCH
        PRINT 'Something wrong during credit apply.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


--EXEC sp_SubmitCreditApplication
--    @AgreementID = 10,
--    @CreditAmount = 150000000,
--    @Tenor = 36,
--    @InterestRate = 4.5,
--    @MonthlyPaymentAmount = 4500000,
--    @CreditStatus = 'smooth',
--    @PaidFully = 0;

--select * from LetterOfIntent
--select * from Agreement
--select * from Credit