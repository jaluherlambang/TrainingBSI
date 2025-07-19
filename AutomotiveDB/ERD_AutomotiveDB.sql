CREATE DATABASE AutomotiveDB;
GO

USE AutomotiveDB;
GO

 -----customer table
CREATE TABLE Customer(
ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) NOT NULL,
CardID VARCHAR(30) NOT NULL,
Address TEXT,
PhoneNumber VARCHAR(15),
Email VARCHAR(30)
);

----- car table
CREATE TABLE Car(
ID INT PRIMARY KEY IDENTITY(1,1),
model VARCHAR(20) NOT NULL,
Type VARCHAR(20),
BasePrice FLOAT,
Color VARCHAR(20),
Stock INT DEFAULT 0
);

-------- Dealer table
CREATE TABLE Dealer(
ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) NOT NULL,
Address TEXT,
PhoneNumber VARCHAR(15),
Email VARCHAR(30),
Status BIT NOT NULL        ----- ACTIVE or NO
);

------- JunctionTableDealerCar
CREATE Table DealerCar(
ID INT PRIMARY KEY IDENTITY(1,1),
CarID INT NOT NULL,
DealerID INT NOT NULL,
Price FLOAT NOT NULL
FOREIGN KEY(CarID) REFERENCES Car(ID),
FOREIGN KEY(DealerID) REFERENCES Dealer(ID)
);

----- SalesPerson Table
CREATE TABLE SalesPerson(
ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) NOT NULL,
DealerID INT NOT NULL,
PhoneNumber VARCHAR(15),
Email VARCHAR(30),
FOREIGN KEY(DealerID) REFERENCES Dealer(ID)
);

------ Counsultation Table
CREATE TABLE ConsultHistory(
ID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
SalesPersonID INT NOT NULL,
Budget FLOAT,
Date DATE DEFAULT GETDATE(),
Note TEXT,
FOREIGN KEY(CustomerID) REFERENCES Customer(ID),
FOREIGN KEY(SalesPersonID) REFERENCES SalesPerson(ID),
);

----- Testdrive Table
CREATE TABLE TestDrive(
ID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
DealerCarID INT NOT NULL,
SalesPersonID INT NOT NULL,
Date DATE DEFAULT GETDATE(),
feedback TEXT
FOREIGN KEY(CustomerID) REFERENCES Customer(ID),
FOREIGN KEY(DealerCarID) REFERENCES DealerCar(ID),
FOREIGN KEY(SalesPersonID) REFERENCES SalesPerson(ID)
);


------ LOI Table
CREATE TABLE LetterOfIntent(
ID INT PRIMARY KEY IDENTITY(1,1),
DealerCarID INT NOT NULL,
Discount FLOAT,
FixPrice FLOAT NOT NULL,
DownPayment FLOAT,
BookingFee FLOAT,
PaymentMethod VARCHAR(10),		----- transfer/cash/credit
FOREIGN KEY(DealerCarID) REFERENCES DealerCar(ID)
);


-------- Agreement Table
CREATE TABLE Agreement(
ID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
SalesPersonID INT,
LoiID INT UNIQUE NOT NULL,
Date DATE DEFAULT GETDATE(),
FOREIGN KEY(LoiID) REFERENCES LetterOfIntent(ID),
FOREIGN KEY(CustomerID) REFERENCES Customer(ID),
FOREIGN KEY(SalesPersonID) REFERENCES SalesPerson(ID),
);

----- credit table
CREATE TABLE Credit(
ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
AgreementID INT UNIQUE NOT NULL,
CreditAmount FLOAT NOT NULL,
Tenor INT, ------ in month
InterestRate FLOAT NOT NULL,
MonthlyPaymentAmount FLOAT NOT NULL,
CreditStatus VARCHAR(20),   ------ e.g. smooth or not
PaidFully BIT NOT NULL,
FOREIGN KEY(AgreementID) REFERENCES Agreement(ID),
);

CREATE TABLE PaymentHistory(
ID INT PRIMARY KEY IDENTITY(1,1),
AgreementID INT NOT NULL,
Amount FLOAT NOT NULL,
PaymentNumber INT,
Date DATE DEFAULT GETDATE(),

FOREIGN KEY (AgreementID) REFERENCES Agreement(ID),
);

-- Tabel WarrantyRegistration
CREATE TABLE WarrantyRegistration (
    WarrantyID INT IDENTITY(1,1) PRIMARY KEY,
    CarID INT NOT NULL,
    PurchaseID INT UNIQUE NOT NULL,
    WarrantyPeriodMonths INT,
    FOREIGN KEY (CarID) REFERENCES Car(ID),
    FOREIGN KEY (PurchaseID) REFERENCES Agreement(ID)
);
GO

-- Tabel WarrantyClaim
CREATE TABLE WarrantyClaim (
    ClaimID INT IDENTITY(1,1) PRIMARY KEY,
    WarrantyID INT NOT NULL,
    IssueReported text NOT NULL,
    ServiceCenter VARCHAR(20) NOT NULL,
    RepairDate DATE NOT NULL,
    RepairCost float NOT NULL,
    ClaimStatus VARCHAR(20) NOT NULL, -- contoh: 'Open', 'Closed', 'Rejected'
    FOREIGN KEY (WarrantyID) REFERENCES WarrantyRegistration(WarrantyID)
);


INSERT INTO Customer (Name, CardID, Address, PhoneNumber, Email) 
VALUES
('Jefri', 'JT123444', 'Jl. Maju Terus gg.4 No.7, Jawa Timur', '081234567890', 'JefriTampang34@gmail.com'),
('Jason', 'DKI10056', 'Jl. Kemana Aja IV No.30, Jakarta', '081234567891', 'JazzJason77@gmail.com'),
('Juliet', 'MT964903', 'Jl. Tapi Mager 2 No.2, Medan', '08123488888', 'citra@mail.com');

INSERT INTO Car (model, Type, BasePrice, Color, Stock) VALUES
('Xpander', 'MPV', 270100000, 'Hitam', 500),
('L300', 'Commercial', 232500000, 'Putih', 300),
('Pajero', 'SUV', 577700000, 'Silver', 250);

INSERT INTO Dealer (Name, Address, PhoneNumber, Email, Status) VALUES
('Dealer Srikandi', 'Jl. Jendral Sudirman', '02195633556', 'dealersrikandi@gmail.com', 1),
('Dealer Berlian', 'Jl. Gatot Subroto', '02106745678', 'dealerberlian@mail.com', 1),
('Dealer Yudha', 'Jl. Thamrin', '021895363', 'dealeryudha@mail.com', 0);

INSERT INTO DealerCar (CarID, DealerID, Price) VALUES
(3, 1, 590700000),
(1, 1, 291500000),
(2, 2, 253700000);

INSERT INTO SalesPerson (Name, DealerID, PhoneNumber, Email) VALUES
('Dina', 1, '081234567001', 'dinasrikandi@gmail.com'),
('Eko', 2, '081234567002', 'ekoberlian@mail.com'),
('Farah', 1, '081234567003', 'farahsrikandi@gmail.com');

INSERT INTO ConsultHistory (CustomerID, SalesPersonID, Budget, Note) VALUES
(3, 1, 250000000, 'Ingin mobil usaha dan tertarik mobil keluarga.'),
(1, 2, 450000000, 'Cari sedan sport.'),
(2, 3, 500000000, 'Tertarik SUV.');

INSERT INTO TestDrive (CustomerID, DealerCarID, SalesPersonID, feedback) VALUES
(1, 1, 3, 'Mobil nyaman dan Gagah. Pelayanan Sales Ramah'),
(2, 2, 2, 'Performa mantap. Cocok untuk keluarga yang punya banyak anak. dealer suasana nyaman dan disambut dengan baik'),
(3, 3, 1, 'Muatan besar sangat tertarik untuk usaha toko bangunan keluarga saya.');

INSERT INTO LetterOfIntent (DealerCarID, Discount, FixPrice, DownPayment, BookingFee, PaymentMethod) VALUES
(1, 10000000, 590700000, 50000000, 5000000, 'credit'),
(2, 5000000, 286500000, 40000000, 2000000, 'cash'),
(3, 7000000, 246700000, 100000000, 3000000, 'transfer');

INSERT INTO Agreement (CustomerID, SalesPersonID, LoiID) VALUES
(1, 2, 1),
(2, 3, 2),
(3, 1, 3);

INSERT INTO Credit (AgreementID, CreditAmount, Tenor, InterestRate, MonthlyPaymentAmount, CreditStatus, PaidFully) VALUES
(1, 581234500, 36, 8.5, 16145000, 'smooth', 0);

INSERT INTO PaymentHistory (AgreementID, Amount, PaymentNumber) VALUES
(1, 16145000, 1),
(1, 16145000, 2),
(2, 286500000, 1),
(3, 246700000, 1);

INSERT INTO WarrantyRegistration (CarID, PurchaseID, WarrantyPeriodMonths) VALUES
(3, 1, 48),
(1, 2, 36),
(2, 3, 24);

INSERT INTO WarrantyClaim (WarrantyID, IssueReported, ServiceCenter, RepairDate, RepairCost, ClaimStatus) VALUES
(1, 'AC tidak dingin', 'Mitsubishi Jkt', '2025-07-01', 2000000, 'Closed'),
(2, 'Lampu mati', 'Service Surabaya', '2025-07-05', 500000, 'Closed'),
(3, 'Mesin bergetar', 'Mitsubishi Serpong', '2025-07-10', 1500000, 'Open');
