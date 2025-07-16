
CREATE DATABASE EmployeeMTPlants;
GO

USE EmployeeMTPlants;
GO

-- Tabel Employee
CREATE TABLE Employee (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PlantID INT NULL,
    Position VARCHAR(25) NULL
);
GO

-- Tabel TrainingCourse
CREATE TABLE TrainingCourse (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Description Text NULL,
    [Duration(minutes)] INT NOT NULL
);
GO

-- Tabel TrainingSession
CREATE TABLE TrainingSession (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    InstructorID INT,
    CourseID INT NOT NULL,
    SessionDate DATE NOT NULL,
    Location VARCHAR(50) NULL,
   --- FOREIGN KEY (InstructorID) REFERENCES Instructor(ID),
    FOREIGN KEY (CourseID) REFERENCES TrainingCourse(ID)
);
GO

-- Tabel Instructor (table many-to-many Employee & TrainingSession)
CREATE TABLE Instructor (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SessionID INT NOT NULL,
    EmployeeID INT NOT NULL,
    FOREIGN KEY (SessionID) REFERENCES TrainingSession(ID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(ID)
);
GO

---- add foreign key to trainingsession
Alter Table TrainingSession
    Add FOREIGN KEY (InstructorID) REFERENCES Instructor(ID);

GO

    
-- Tabel ParticipationRecord (table many-to-many Employee & TrainingSession)
CREATE TABLE ParticipationRecord (
    SessionID INT NOT NULL,
    EmployeeID INT NOT NULL,
    Date DATE NOT NULL,
    PassedAssessment BIT NOT NULL,
    PRIMARY KEY (SessionID, EmployeeID),
    FOREIGN KEY (SessionID) REFERENCES TrainingSession(ID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(ID)
);
GO
