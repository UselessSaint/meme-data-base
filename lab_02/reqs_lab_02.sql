USE Factory
GO

-- 1 cmp
select *
from Models
where Type = 'C'
GO

-- 2 Between
select *
from Factory
where RegionID between 0 and 100
GO

-- 3 Like
select *
from Client
where Client.Full_Name like 'B%'
GO

-- 4 IN
select Models.*
from Models
where Models.ID in (
		select ModelID
		from Factory_Models_conection as FMC
		where FactoryID between 0 and 10 )
order by Models.ID
GO

-- 5 Exists
select T1.*
from Client as T1
where not Exists ( select OrderInfo.*
				   from OrderInfo
				   where OrderInfo.Сlient = T1.ID )
GO

-- 6 cmp + kv
select Factory.*
from Factory
where Date_Of_Construction <> ALL (select Date_Of_Construction
								   from Factory
								   where Date_Of_Construction between '12.01.1900' and '12.01.2000' )
GO

-- 7 agr
select Models.Name, T1.Num
from Models, (select ModelID, count(ModelID) as Num
			  from OrderInfo
			  group by ModelID) as T1
where Models.ID = T1.ModelID
GO

-- 8 scl subreq
select Region.*, (  select Max(Factory.Date_Of_Construction)
					from Factory
					where Factory.RegionID = Region.ID) as NewestFactoryDate,
				 (	select Count(ID)
					from Factory
					where Factory.RegionID = Region.ID) as NumOfFactoryes
from Region
GO

-- 9 noob case
select Factory.ID, case YEAR(Factory.Date_Of_Construction)
						when YEAR(getdate()) then 'This year'
						else'Not this year'
				   end as 'When'
from Factory
GO

-- 10 pro case
select Region.Name, Region.Population,	case 
											when Region.Population < 1000000 then 'Low population'
											when Region.Population < 5000000 then 'High population'
											else 'Extra high population'
										end as Rating
from Region
GO

-- 11 local table
select Models.Name, T1.Num
into #AmountOfOrders
from Models, (select ModelID, count(ModelID) as Num
			  from OrderInfo
			  group by ModelID) as T1
where Models.ID = T1.ModelID
GO
select * from #AmountOfOrders order by Num desc
GO

select * from tempdb.sys.tables
GO

-- 12
select Factory.ID, Factory.RegionID
from Factory inner join ( select FactoryID
						  from Factory_Models_conection
						  where ModelID < 100 
						  union
						  select FactoryID
						  from Factory_Models_conection
						  where ModelID between 400 and 500 
						  ) as tmp on Factory.ID = tmp.FactoryID
GO
-- 13 Все фабрики, на которых можно произвести модели с U на которые есть заказ
select ID
from Factory
where ID in (	select FactoryID
				from Factory_Models_conection
				where ModelID in (	select ModelID
									from OrderInfo
									where ModelID in (	select ModelID
														from Models
														where Type = 'U' )))
GO

-- 14 Номер модели и кол-во заказов на неё (group by)
select ModelID, count(ModelID) as Num
from OrderInfo
group by ModelID
GO

-- 15 Все номера моделей на которые 3 заказа
select ModelID, count(ModelID) as Num
from OrderInfo
group by ModelID
having count(ModelID) = 3
GO

-- 16 insert
insert Region (Population, Name) values (10, 'tmp')
GO
select * from Region order by Population
GO

-- 17 
create table #tmp (ID int, Population Int, Name nvarchar(50))
GO

insert #tmp(ID, Population, Name)
select *
from Region
where Name like 'A%'
GO

select * from #tmp
order by ID
GO

-- 18
update #tmp
Set Population = 100
where ID between 100 and 500

-- 19
update #tmp
set Population = (	select max(Population)
					from #tmp	)
where ID between 100 and 200

-- 20
delete #tmp
where ID between 100 and 200

-- 21
delete #tmp
where ID in (	select RegionID
				from Factory
				where ID > 100 and #tmp.Name like '%n'	)

-- 22 OTV
with T1 as (select ModelID, count(ModelID) as Num
			  from OrderInfo
			  group by ModelID)
select Models.Name, T1.Num
from Models, T1
where Models.ID = T1.ModelID
GO



-- 23
create table #recOtv ( Id int, Parent int)
GO

insert into #recOtv values (1, null), (2, 1), (3, 2), (4, null), (5, 4)
GO

select * from #recOtv
GO

with Tree as ( 
	select r.Id, r.Parent, 0 as Level
	from #recOtv as r
	where r.Parent is null
	union all
	select r.Id, r.Parent, Level + 1
	from #recOtv as r inner join Tree as t on r.Parent = t.Id )
select * 
from Tree

-- 24
with T1 as (select ModelID, count(ModelID) as Num
			  from OrderInfo
			  group by ModelID)
select * 
from (		select  Models.Type, 
					Max(T1.Num)over(Partition by Models.Type) as MaxOrd, 
					Min(T1.Num)over(Partition by Models.Type) as MinOrd,
					Avg(T1.Num)over(Partition by Models.Type) as AvgOrd
			from Models, T1
			where Models.ID = T1.ModelID ) as tmp

group by Type, MaxOrd, MinOrd, AvgOrd
GO

-- 25
create table #tmp (ID int, Population Int, Name nvarchar(50))
GO

insert #tmp(ID, Population, Name)
select *
from Region
where Name like 'A%'
GO

select * from #tmp
order by ID
GO

with T1 as (	select ID, Population, Name, 
						ROW_NUMBER() over (partition by ID, Population, Name order by ID) as t
				from #tmp	)
select ID, Population, Name
from T1
where t = 1
GO


-------

USE master
GO




