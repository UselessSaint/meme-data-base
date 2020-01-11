use Factory
GO

-- // fst

declare @temp nvarchar(4000)
set @temp = 
	(
		select *
		from Client
		for json path,  ROOT('data')
	)
select @temp

-- // snd

declare @tmp nvarchar(4000)
set @tmp = (
SELECT * FROM OPENROWSET(BULK N'C:\Users\Tree\Desktop\Progs\meme-data-base\lab_05\data.json', SINGLE_CLOB) AS Contents
)
select isjson(@tmp)

select *
from openjson(@tmp, N'$.root')
with (
	fst_apples	int		N'$.fst_branch.Apples',
	fst_worms	int		N'$.fst_branch.Worms',
	snd_apples	int		N'$.snd_branch.Apples',
	snd_worms	int		N'$.snd_branch.Worms'
)