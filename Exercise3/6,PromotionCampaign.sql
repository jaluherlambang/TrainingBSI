 CREATE DATABASE PromotionCampaign;
GO

USE PromotionCampaign;
GO


-- Table: CarModel
CREATE TABLE CarModel (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Manufacturer VARCHAR(50) NOT NULL,            
    Year SMALLINT  
);

-- Table: Dealer
CREATE TABLE Dealer (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(30) NOT NULL,
    Location VARCHAR(50),
    Email VARCHAR(30),
    PhoneNumber VARCHAR(20),
);

-- Table: PromotionCampaign
CREATE TABLE PromotionCampaign (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL, 
    EndDate DATE NOT NULL, 
    DiscountPercent FLOAT NOT NULL,
    Region VARCHAR(30) NOT NULL,

);

-- Junction Table: CampaignCarModel
CREATE TABLE CampaignCarModel (
    CampaignID INT NOT NULL,
    CarModelID INT NOT NULL,
    EligibleDate DATE NOT NULL,
    PRIMARY KEY (CampaignID, CarModelID),
    FOREIGN KEY (CampaignID) REFERENCES PromotionCampaign(ID),
    FOREIGN KEY (CarModelID) REFERENCES CarModel(ID)
);

-- Junction Table: CampaignDealer
CREATE TABLE CampaignDealer (
    CampaignID INT NOT NULL,
    DealerID INT NOT NULL,
    PRIMARY KEY (CampaignID, DealerID),
    FOREIGN KEY (CampaignID) REFERENCES PromotionCampaign(ID),
    FOREIGN KEY (DealerID) REFERENCES Dealer(ID)
);

---- Dealer sells which CarModel (independent of campaign)
CREATE TABLE DealerCarModel (
    DealerID INT NOT NULL,
    CarModelID INT NOT NULL,
    PRIMARY KEY (DealerID, CarModelID),
    FOREIGN KEY (DealerID) REFERENCES Dealer(ID),
    FOREIGN KEY (CarModelID) REFERENCES CarModel(ID)
);

-- Table: CustomerBenefit
CREATE TABLE CustomerBenefit (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CampaignID INT NOT NULL,                     
    CarModelID INT NOT NULL,                   
    DealerID INT NOT NULL,                          
    CustomerName VARCHAR(30) NOT NULL,
    BenefitDescription TEXT, 
    FOREIGN KEY (CampaignID) REFERENCES PromotionCampaign(ID),
    FOREIGN KEY (CarModelID) REFERENCES CarModel(ID),
    FOREIGN KEY (DealerID) REFERENCES Dealer(ID)
);
