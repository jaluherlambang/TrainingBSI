CREATE DATABASE AutomotiveMaster;
GO

USE AutomotiveMaster;
GO

 -----customer table
CREATE TABLE Customer(
ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) NOT NULL,
CardID VARCHAR(30) NOT NULL,
Address TEXT,
PhoneNumber VARCHAR(15),
EMAIL VARCHAR(30)
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
EMAIL VARCHAR(30),
Status BIT NOT NULL        ----- ACTIVE or NO
);

----- SalesPerson Table
CREATE TABLE SalesPerson(
ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) NOT NULL,
PhoneNumber VARCHAR(15),
Email VARCHAR(30)
);

------ Counsultation Table
CREATE TABLE ConsultHistory(
ID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
DealerID INT NOT NULL,
SalesPersonID INT NOT NULL,
CarID INT,
Budget FLOAT,
Date DATE DEFAULT GETDATE(),
Note TEXT,

FOREIGN KEY(CustomerID) REFERENCES Customer(ID),
FOREIGN KEY(DealerID) REFERENCES Dealer(ID),
FOREIGN KEY(SalesPersonID) REFERENCES SalesPerson(ID),
FOREIGN KEY(CarID) REFERENCES Car(ID)
);

----- Testdrive Table
CREATE TABLE TestDrive(
ID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
DealerID INT NOT NULL,
SalesPersonID INT NOT NULL,
Date DATE DEFAULT GETDATE(),
feedback TEXT

FOREIGN KEY(CustomerID) REFERENCES Customer(ID),
FOREIGN KEY(DealerID) REFERENCES Dealer(ID),
FOREIGN KEY(SalesPersonID) REFERENCES SalesPerson(ID)
);


------ LOI Table
CREATE TABLE LetterOfIntent(
ID INT PRIMARY KEY IDENTITY(1,1),
FixPrice FLOAT NOT NULL,
Discount FLOAT,
DownPayment FLOAT,
BookingFee FLOAT,
PaymentMethod VARCHAR(10),		----- transfer/cash/credit
);


-------- Agreement Table
CREATE TABLE Agreement(
ID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
DealerID INT NOT NULL,
SalesPersonID INT,
CarID INT NOT NULL,
LoiID INT NOT NULL,
Date DATE DEFAULT GETDATE(),

FOREIGN KEY(LoiID) REFERENCES LetterOfIntent(ID),
FOREIGN KEY(CustomerID) REFERENCES Customer(ID),
FOREIGN KEY(DealerID) REFERENCES Dealer(ID),
FOREIGN KEY(SalesPersonID) REFERENCES SalesPerson(ID),
FOREIGN KEY(CarID) REFERENCES Car(ID)
);

----- credit table
CREATE TABLE Credit(
ID INT PRIMARY KEY IDENTITY(1,1),
AgreementID INT NOT NULL,
CreditAmount FLOAT NOT NULL,
Tenor INT, ------ in month
InterestRate FLOAT NOT NULL,
MonthlyPaymentAmount FLOAT NOT NULL,
CreditStatus VARCHAR(20),   ------ e.g. smooth or not
PaidFully BIT NOT NULL,

-- Foreign Key
FOREIGN KEY (AgreementID) REFERENCES Agreement(ID)
);

CREATE TABLE PaymentHistory(
ID INT PRIMARY KEY IDENTITY(1,1),
AgreementID INT NOT NULL,
CreditID INT,
Amount FLOAT NOT NULL,
PaymentNumber INT,
Date DATE DEFAULT GETDATE(),

FOREIGN KEY (AgreementID) REFERENCES Agreement(ID),
FOREIGN KEY (CreditID) REFERENCES Credit(ID)
);