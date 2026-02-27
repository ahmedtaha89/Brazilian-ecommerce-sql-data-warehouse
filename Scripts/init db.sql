-- Create database
CREATE DATABASE Brazilian_E_Commerce;
GO

-- Switch to the database
USE Brazilian_E_Commerce;
GO

-- Create schemas (Medallion layers)
CREATE SCHEMA bronze;  -- Raw / landing layer
GO

CREATE SCHEMA silver;  -- Cleaned / standardized layer
GO

CREATE SCHEMA gold;    -- Curated / business layer
GO


CREATE LOGIN [ahmedtaha89_dw] WITH PASSWORD = '123';
GO


CREATE USER [ahmedtaha89_dw] FOR LOGIN [ahmedtaha89_dw];
GO

ALTER ROLE db_owner ADD MEMBER [ahmedtaha89_dw];
GO