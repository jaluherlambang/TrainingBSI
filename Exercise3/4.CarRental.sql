CREATE DATABASE CarRental;
GO

USE CarRental;
GO

-- Tabel RentalBranch
CREATE TABLE RentalBranch (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Location VARCHAR(60) NULL
);
GO

-- Tabel Vehicle
CREATE TABLE Vehicle (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    BranchID INT NOT NULL,
    LicensePlate VARCHAR(15) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year SMALLINT NULL,
    Status VARCHAR(20) NOT NULL,      -- contoh: Available, Rented, Maintenance
    Mileage INT NOT NULL default 0,
    FOREIGN KEY (BranchID) REFERENCES RentalBranch(ID)
);
GO

-- Tabel Customer
CREATE TABLE Customer (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NULL,
    Email VARCHAR(50) NULL
);
GO

-- Tabel Employee
CREATE TABLE Employee (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Position VARCHAR(20) NULL,
    BranchID INT NOT NULL,
    FOREIGN KEY (BranchID) REFERENCES RentalBranch(ID)
);
GO

-- Tabel RentalContract
CREATE TABLE RentalContract (
    ContractID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    VehicleID INT NOT NULL,
    EmployeeID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalDays INT NOT NULL,
    DailyRate Float NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(ID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(ID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(ID),
);
GO
