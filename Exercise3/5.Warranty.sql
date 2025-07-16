
 CREATE DATABASE Warranty;
GO

USE Warranty;
GO

-- Tabel Customer
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(50)
);
GO

-- Tabel Car
CREATE TABLE Car (
    VIN VARCHAR(30) PRIMARY KEY,
    Model VARCHAR(50) NOT NULL,
    Year SMALLINT NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO

-- Tabel WarrantyRegistration
CREATE TABLE WarrantyRegistration (
    WarrantyID INT IDENTITY(1,1) PRIMARY KEY,
    VIN VARCHAR(30) NOT NULL UNIQUE,
    PurchaseDate DATE NOT NULL,
    WarrantyPeriodMonths INT NOT NULL CHECK (WarrantyPeriodMonths > 0),
    CONSTRAINT FK_Warranty_Car FOREIGN KEY (VIN) REFERENCES Car(VIN)
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
GO
