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