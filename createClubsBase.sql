SET DATEFORMAT mdy;  
GO  

USE master;
IF EXISTS (SELECT Name FROM sys.databases WHERE name='ClubsBase')
  ALTER DATABASE ClubsBase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE IF EXISTS ClubsBase;
GO
CREATE DATABASE ClubsBase;
GO
ALTER DATABASE ClubsBase SET RECOVERY SIMPLE;

USE ClubsBase;

DROP TABLE IF EXISTS Cities ;
DROP TABLE IF EXISTS Clubs ;
DROP TABLE IF EXISTS Persons ;
DROP TABLE IF EXISTS PersonsToClubs ;

DROP TABLE IF EXISTS Cities;
CREATE TABLE Cities (
  CityID BIGINT IDENTITY(1,1) NOT NULL,
  CityName NVARCHAR(20) NOT NULL,
  CONSTRAINT PK_CityID PRIMARY KEY (CityID),
  CONSTRAINT UQ_CityName UNIQUE (CityName)
);

DROP TABLE IF EXISTS Clubs ;
CREATE TABLE Clubs  (
	ClubID BIGINT IDENTITY(1,1) NOT NULL,
	ClubName NVARCHAR(20) NOT NULL,
	CreationDate DATE,
	CityID BIGINT,
	CONSTRAINT PK_ClubID PRIMARY KEY (ClubID),
	CONSTRAINT UQ_ClubName UNIQUE (ClubName),
	CONSTRAINT FK_Clubs_To_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

DROP TABLE IF EXISTS Persons ;
CREATE TABLE Persons  (
	PersonID BIGINT IDENTITY(1,1) NOT NULL,
	IIN  CHAR(12) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	FirstName NVARCHAR(20) NOT NULL,
	Birthday DATE,
	ClubID BIGINT,
	CONSTRAINT PK_PersonID PRIMARY KEY (PersonID),
	CONSTRAINT UQ_Persons_IIN UNIQUE (IIN),
	CONSTRAINT FK_Persons_To_Clubs FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID)
);

DROP TABLE IF EXISTS PersonsToClubs;
CREATE TABLE PersonsToClubs (
  ID BIGINT IDENTITY(1,1) NOT NULL,
  PersonID BIGINT NOT NULL,
  ClubID BIGINT NOT NULL,
  CONSTRAINT PK_ID PRIMARY KEY (ID),
  CONSTRAINT FK_PersonID FOREIGN KEY (PersonID) REFERENCES Persons(PersonID),
  CONSTRAINT FK_ClubID FOREIGN KEY (ClubID) REFERENCES Clubs(ClubID),
);


--SET IDENTITY_INSERT Cities ON;
INSERT INTO Cities (CityName) VALUES ('Astana' );
INSERT INTO Cities (CityName) VALUES ('Almaty' );
INSERT INTO Cities (CityName) VALUES ('Karaganda' );
--SET IDENTITY_INSERT Cities OFF;

--SET IDENTITY_INSERT Clubs ON;
INSERT INTO Clubs (ClubName, CreationDate, CityID) VALUES ('FKAstana', '2000-10-21', 1 );
INSERT INTO Clubs (ClubName, CreationDate, CityID) VALUES ('FKKairat', '1999-10-21', 2 );
INSERT INTO Clubs (ClubName, CreationDate, CityID) VALUES ('FKShahter', '1998-10-21', 3 );
--SET IDENTITY_INSERT Clubs OFF;

--SET IDENTITY_INSERT Persons ON;
INSERT INTO Persons (IIN, LastName, FirstName, Birthday, ClubID) VALUES ('040430124047', 'Ullrich', 'Rita', '2004-04-30', 1);
INSERT INTO Persons (IIN, LastName, FirstName, Birthday, ClubID) VALUES ('811207176352', 'Gerlach', 'Vito', '1981-12-07', 2);
INSERT INTO Persons (IIN, LastName, FirstName, Birthday, ClubID) VALUES ('910913787530', 'Hilpert', 'Selina', '1991/09/13', 3);
--SET IDENTITY_INSERT Persons ON;

--SET IDENTITY_INSERT PersonsToClubs ON;
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (1,1);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (1,2);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (1,3);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (2,1);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (2,2);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (2,3);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (3,1);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (3,2);
INSERT INTO PersonsToClubs (PersonID, ClubID) VALUES (3,3);
--SET IDENTITY_INSERT PersonsToClubs OFF;