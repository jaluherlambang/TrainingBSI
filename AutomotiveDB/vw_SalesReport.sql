CREATE VIEW vw_SalesReport AS
SELECT 
    a.AgreementID,
    c.Name AS CustomerName,
    sp.Name AS SalesPersonName,
    car.model AS CarModel,
    car.Type AS CarType,
    d.Name AS DealerName,
    loi.FinalPrice,
    loi.PaymentMethod,
    a.Date AS AgreementDate
FROM Agreement a
JOIN Customer c ON a.CustomerID = c.CustomerID
JOIN SalesPerson sp ON a.SalesPersonID = sp.SalesID
JOIN LetterOfIntent loi ON a.LoiID = loi.LoiID
JOIN DealerCar dc ON loi.DealerCarID = dc.DealerCarID
JOIN Car car ON dc.CarID = car.CarID
JOIN Dealer d ON dc.DealerID = d.DealerID;


---- Lihat semua laporan penjualan
--SELECT * FROM vw_SalesReport;