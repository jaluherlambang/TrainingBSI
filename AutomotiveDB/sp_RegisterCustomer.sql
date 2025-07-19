CREATE PROCEDURE sp_RegisterCustomer 
    @Name VARCHAR(30) = '',
    @CardID VARCHAR(30) = '',
    @Address TEXT = '',
    @PhoneNumber VARCHAR(15) = '',
    @Email VARCHAR(30) = ''
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Customer (Name, CardID, Address, PhoneNumber, Email)
    VALUES (@Name, @CardID, @Address, @PhoneNumber, @Email);
    
    PRINT 'Customer registration successful.';
END;



--EXEC sp_RegisterCustomer 
--    @Name = 'Rina', 
--    @CardID = 'ID20250101', 
--    @Address = 'Jl. Kenangan No. 7', 
--    @PhoneNumber = '081234567899', 
--    @Email = 'rina@gmail.com';

--    select * from Customer