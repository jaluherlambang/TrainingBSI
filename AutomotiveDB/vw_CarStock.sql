CREATE VIEW vw_CarStock AS
SELECT 
    dc.DealerCarID,
    car.CarID,
    car.model AS CarModel,
    car.Type,
    car.Color,
    d.Name AS DealerName,
    dc.Price,
    dc.Stock AS StockDealer,              -- stok in dealer
    car.Stock AS StockMaster       -- stok in master Car
FROM DealerCar dc
JOIN Car car ON dc.CarID = car.CarID
JOIN Dealer d ON dc.DealerID = d.DealerID
WHERE dc.Stock > 0;

--SELECT * FROM vw_CarStock;
