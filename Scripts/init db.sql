-- Create database
CREATE DATABASE [Brazilian E-Commerce];
GO

-- Switch to the database
USE [Brazilian E-Commerce];
GO

-- Create schemas (Medallion layers)
CREATE SCHEMA bronze;  -- Raw / landing layer
GO

CREATE SCHEMA silver;  -- Cleaned / standardized layer
GO

CREATE SCHEMA gold;    -- Curated / business layer
GO
