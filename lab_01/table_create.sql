USE master
GO

IF EXISTS (
	SELECT name
	FROM sys.databases
	WHERE name = 'Factory'
)
DROP DATABASE Factory
GO

CREATE DATABASE Factory
GO

USE Factory
GO

CREATE TABLE Region (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Population int not null,
	Name nvarchar(50) not null
)
GO

CREATE TABLE Factory (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Date_Of_Construction date not null,
	RegionID int REFERENCES Region(ID) not null
)
GO

CREATE TABLE Models (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(50) not null,
	Type char not null 
)
GO

CREATE TABLE Factory_Models_conection (
	FactoryID int REFERENCES Factory(ID) not null,
	ModelID int REFERENCES Models(ID) not null
)
GO

CREATE TABLE Client (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Full_name nvarchar(150) not null
)
GO

CREATE TABLE OrderInfo (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Ñlient int REFERENCES Client(ID) not null,
	ModelID int REFERENCES Models(ID) not null,
	Date_of_receiving date not null,
	Completion_date date not null,
	Android_id int not null
)
GO

