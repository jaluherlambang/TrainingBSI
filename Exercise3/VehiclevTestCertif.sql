-- create database
CREATE DATABASE VehiclevTestCertif;
USE VehiclevTestCertif;

-- Tabel CarModel
CREATE TABLE CarModel (
    ModelID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    ReleaseYear smallint NOT NULL
);

-- Tabel PrototypeVehicle
CREATE TABLE PrototypeVehicle (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CarModelID INT NOT NULL,
    SerialNumber VARCHAR(50) NOT NULL,
    ManufactureDate DATE NOT NULL,
    FOREIGN KEY (CarModelID) REFERENCES CarModel(CarModelID)
);

-- Tabel TestEngineer
CREATE TABLE TestEngineer (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Expertise VARCHAR(50)
);

-- Tabel TestLocation
CREATE TABLE TestLocation (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(150)
);

-- Tabel VehicleTest
CREATE TABLE VehicleTest (
    TestID INT IDENTITY(1,1) PRIMARY KEY,
    PrototypeID INT NOT NULL,
    EngineerID INT NOT NULL,
    LocationID INT NOT NULL,
    TestDate DATE NOT NULL,
    TestType VARCHAR(50) NOT NULL,
    TestResult bit NOT NULL,
    Notes TEXT,
    FOREIGN KEY (PrototypeID) REFERENCES PrototypeVehicle(PrototypeID),
    FOREIGN KEY (EngineerID) REFERENCES TestEngineer(EngineerID),
    FOREIGN KEY (LocationID) REFERENCES TestLocation(LocationID)
);
