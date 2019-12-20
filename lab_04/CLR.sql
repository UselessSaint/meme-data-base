EXEC sp_configure 'clr enabled', 1;  
RECONFIGURE;  
GO 

alter database Factory set trustworthy ON;

Use Factory

-- // Scalar

CREATE ASSEMBLY scalar FROM 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04\scal.dll'
GO

create function amountOfOrders() returns int
as external NAME scalar.Scal.amountOfOrders;
GO

select dbo.amountOfOrders()
GO

-- // User ARG func

create ASSEMBLY Dec from 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04\agr.dll'
GO

create table #tmp(a int)

insert into #tmp values (1), (2), (3), (4)

select * from #tmp

create aggregate Dec (@input int) returns int
external NAME Dec.Dec

select dbo.Dec(#tmp.a)
from #tmp

-- // Table

CREATE ASSEMBLY interval FROM 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04\table.dll';  
GO

create function dbo.interval(@a int)
returns table (ID int)
as
external name interval.[pow2.TableValuedFunction].GenerateInterval
go

select * from dbo.interval(20)


