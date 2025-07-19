CREATE VIEW vw_CreditStatus AS
SELECT 
    cr.CreditID,
    c.Name AS CustomerName,
    car.model AS CarModel,
    cr.CreditAmount,
    cr.Tenor,
    cr.InterestRate,
    cr.MonthlyPaymentAmount,
    cr.CreditStatus,
    CASE WHEN cr.PaidFully = 1 THEN 'Paid Full' ELSE 'Unpaid Fully' END AS PaymentStatus,
    COUNT(ph.PaymentID) AS PaymentCount
FROM Credit cr
JOIN Agreement a ON cr.AgreementID = a.AgreementID
JOIN Customer c ON a.CustomerID = c.CustomerID
JOIN LetterOfIntent loi ON a.LoiID = loi.LoiID
JOIN DealerCar dc ON loi.DealerCarID = dc.DealerCarID
JOIN Car car ON dc.CarID = car.CarID
LEFT JOIN PaymentHistory ph ON cr.AgreementID = ph.AgreementID
GROUP BY 
    cr.CreditID, c.Name, car.model, cr.CreditAmount, cr.Tenor,
    cr.InterestRate, cr.MonthlyPaymentAmount, cr.CreditStatus, cr.PaidFully;


--SELECT * FROM CREDIT
--SELECT * FROM vw_CreditStatus;
--SELECT * FROM PaymentHistory;