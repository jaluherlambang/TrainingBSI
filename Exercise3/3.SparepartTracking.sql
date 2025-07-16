CREATE DATABASE SparepartTracking;
GO

USE SparepartTracking;
GO

-- Tabel PartCategory
CREATE TABLE PartCategory (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);
GO

-- Tabel Part
CREATE TABLE Part (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    PartName VARCHAR(50) NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES PartCategory(ID)
);
GO

-- Tabel Supplier
CREATE TABLE Supplier (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NULL
);
GO

-- Tabel SupplierPartOffer
CREATE TABLE SupplierPartOffer (
    SupplierID INT NOT NULL,
    PartNumber INT NOT NULL,
    Price INT NOT NULL,
    LeadTimeDays INT NOT NULL,
    Rating FLOAT NOT NULL CHECK (Rating >= 0 AND Rating <= 5),
    PRIMARY KEY (SupplierID, PartNumber),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(ID),
    FOREIGN KEY (PartNumber) REFERENCES Part(ID)
);
GO
