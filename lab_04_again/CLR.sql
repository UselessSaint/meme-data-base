EXEC sp_configure 'clr enabled', 1;  
RECONFIGURE;  
GO 

alter database Factory set trustworthy ON;

Use Factory

-- // Scalar

CREATE ASSEMBLY scalar FROM 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04_again\scal.dll'
GO

create function amountOfOrders() returns int
as external NAME scalar.Scal.amountOfOrders;
GO

select dbo.amountOfOrders()
GO

-- // User ARG func

drop assembly sqrSum
GO

create ASSEMBLY sqrSum from 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04_again\agr.dll'
GO

create table #tmp(a int)

insert into #tmp values (1), (2), (3), (4)

select * from #tmp

create aggregate sqrSum (@input int) returns int
external NAME sqrSum.sqrSum

select dbo.sqrSum(#tmp.a)
from #tmp

-- // Table

drop assembly interval
GO

CREATE ASSEMBLY interval FROM 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04_again\table.dll';  
GO

drop function dbo.interval
GO

create function dbo.interval(@a int)
returns table (ID int)
as
external name interval.[pow2.TableValuedFunction].GenerateInterval
go

select * from dbo.interval(10)


-- // proc

drop assembly cnt
GO

CREATE ASSEMBLY cnt FROM 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04_again\proc.dll';  
GO

drop procedure cnt
GO

CREATE PROCEDURE cnt (@sum int OUTPUT)  
AS EXTERNAL NAME cnt.StoredProcedures.cnt
Go

declare @rets int
exec cnt @rets output
select @rets

-- // trigger

drop assembly trg
GO

CREATE ASSEMBLY trg FROM 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04_again\trigger.dll';  
GO

drop trigger trig
Go

create table tstt (i int)
GO

create trigger trig on tstt instead of delete as
EXTERNAL NAME trg.CLRTriggers.DropTableTrigger
go

insert into tstt values (1)

delete from tstt
select * from tstt

-- // type

drop assembly vec
GO

CREATE ASSEMBLY vec FROM 'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_04_again\type.dll';  
GO

drop type Vector
GO

CREATE TYPE Vector  
EXTERNAL NAME vec.[Vector]
GO

drop table ttst

create table ttst (hey Vector)
GO

insert into ttst values ('1,0,0'), ('12, 13, 14')

select hey.Len() from ttst