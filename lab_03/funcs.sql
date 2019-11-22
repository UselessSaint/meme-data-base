-----------------------------------------------------------------------------

-- Скалярная функция

IF OBJECT_ID (N'dbo.amount_of_type_orders', N'FN') IS NOT NULL
    DROP FUNCTION dbo.amount_of_type_orders
GO

create function amount_of_type_orders(@Type char)
returns int as
begin
	return (	select count(*)
				from OrderInfo inner join Models on ModelID = Models.ID
				where type = @Type )
end 
GO

select dbo.amount_of_type_orders('C')


-- Подст. табл. ф-я

IF OBJECT_ID (N'dbo.orders_of_type', N'FN') IS NOT NULL
    DROP FUNCTION dbo.orders_of_type
GO

create function orders_of_type(@Type char)
returns TABLE
as 
return (
	select O.*
	from OrderInfo as O inner join Models as M on O.ModelID = M.ID and M.Type = @Type
		)
GO

select * from dbo.orders_of_type('C')

-- Многоопер. табл. ф-ция.

IF OBJECT_ID (N'dbo.amount_of_orders_on_model', N'FN') IS NOT NULL
    DROP FUNCTION dbo.amount_of_orders_on_model
GO

create function dbo.amount_of_orders_on_model()
returns @AmontOfOrders Table
(
	MName nvarchar(50),
	Amount int
)
as
begin
	Insert into @AmontOfOrders
	select Models.Name, T1.Num
	from Models, (select ModelID, count(ModelID) as Num
			  from OrderInfo
			  group by ModelID) as T1
	where Models.ID = T1.ModelID
return
END
GO

select * from dbo.amount_of_orders_on_model()


-- Рекурсивная фун-ция


IF OBJECT_ID (N'dbo.fact', N'FN') IS NOT NULL
    DROP FUNCTION dbo.fact
GO

create function dbo.fact (@n int)
returns int as
begin
	if @n = 0
		return 1;

	return @n * dbo.fact(@n-1);
end
go

select dbo.fact(3)
go


-----------------------------------------------------------------------------

-- Процедура без параметров

IF OBJECT_ID (N'dbo.getCTypeOrders', 'P') IS NOT NULL
    DROP PROCEDURE dbo.getCTypeOrders
GO

create procedure getCTypeOrders
as
begin
	select O.*
	from OrderInfo as O inner join Models as M on O.ModelID = M.ID and M.Type = 'C'
end
go

exec getCTypeOrders
go

-- хранимую процедур с рекурсивным ОТВ
create table #recOtv ( Id int, Parent int)
GO

insert into #recOtv values (1, null), (2, 1), (3, 2), (4, null), (5, 4)
GO

select * from #recOtv
GO

IF OBJECT_ID (N'dbo.treeWooh', 'P') IS NOT NULL
    DROP PROCEDURE dbo.treeWooh
GO

create procedure treeWooh
as
begin
	with Tree as ( 
		select r.Id, r.Parent, 0 as Level
		from #recOtv as r
		where r.Parent is null
		union all
		select r.Id, r.Parent, Level + 1
		from #recOtv as r inner join Tree as t on r.Parent = t.Id )
	select * 
	from Tree
end
go

exec treeWooh
go

-- Процедура с курсором

IF OBJECT_ID (N'dbo.takemodelsnames', 'P') IS NOT NULL
    DROP PROCEDURE dbo.takemodelsnames
GO

create procedure takemodelsnames
as
begin
	declare @oh nvarchar(255)
	
	declare curs cursor for
		select Name from Models

	open curs

	declare @i int
	set @i = 0

	while (@i < 10)
	begin
		fetch next from curs into @oh
		print @oh
		set @i = @i + 1
	end

	close curs
	deallocate curs

	print @oh
end
go

exec takemodelsnames
go

-- проц. доступа к метаданным

IF OBJECT_ID (N'dbo.checkExistingTables', 'P') IS NOT NULL
    DROP PROCEDURE dbo.checkExistingTables
GO

create procedure checkExistingTables
as
begin
	select name, create_date, modify_date from sys.tables
end
go

exec checkExistingTables
go

-------------------------------------------------------
-- after

create table tmp (
	string nvarchar(50) 
	)
go

create table history (
	string nvarchar(50),
	act nvarchar(50),
	time datetime
	)
go

drop trigger checkTmp
go

create trigger checkTmp
on tmp
after insert, delete
as
begin
	declare @actionType nvarchar(50)

	set @actionType = case
			when (select count(*) from deleted) > 0 and (select count(*) from inserted) = 0 then N'delete'
			when (select count(*) from inserted) > 0 and (select count(*) from deleted) = 0 then N'insert'
			else N'nothing'
		end

	declare @string nvarchar(50)

	if (@actionType = N'delete')
		begin
			insert into history
			select *, @actionType, GETDATE()
			from deleted
		end
	else if (@actionType = N'insert')
		begin
			insert into history
			select *, @actionType, GETDATE()
			from inserted
		end
end
go

insert into tmp values ('junk')
delete from tmp where string = 'junk'
delete from history

select * from tmp
select * from history


