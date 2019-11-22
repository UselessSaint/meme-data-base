USE Factory	
GO

BULK INSERT Client
FROM 'C:\Users\blueberrypie\Desktop\Progs\meme-data-base\lab_01\client_data.txt'
WITH (FIELDTERMINATOR = ' ; ', ROWTERMINATOR = '\n')
GO

BULK INSERT Region
FROM 'C:\Users\blueberrypie\Desktop\Progs\meme-data-base\lab_01\region_data.txt'
WITH (FIELDTERMINATOR = ' ; ', ROWTERMINATOR = '\n')
GO

BULK INSERT Factory
FROM 'C:\Users\blueberrypie\Desktop\Progs\meme-data-base\lab_01\factory_data.txt'
WITH (FIELDTERMINATOR = ' ; ', ROWTERMINATOR = '\n')
GO

BULK INSERT Models
FROM 'C:\Users\blueberrypie\Desktop\Progs\meme-data-base\lab_01\model_data.txt'
WITH (FIELDTERMINATOR = ' ; ', ROWTERMINATOR = '\n')
GO

BULK INSERT Factory_Models_conection
FROM 'C:\Users\blueberrypie\Desktop\Progs\meme-data-base\lab_01\conection_data.txt'
WITH (FIELDTERMINATOR = ' ; ', ROWTERMINATOR = '\n')
GO

BULK INSERT OrderInfo
FROM 'C:\Users\blueberrypie\Desktop\Progs\meme-data-base\lab_01\order_data.txt'
WITH (FIELDTERMINATOR = ' ; ', ROWTERMINATOR = '\n')
GO

USE master
GO