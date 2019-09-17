USE Factory
GO

ALTER TABLE Region ADD 
	CONSTRAINT pop_above_zero check (Population > 0),
	CONSTRAINT Rname_not_empty check (Name != '')
GO

ALTER TABLE Models ADD 
	CONSTRAINT type_not_empty check (Type != ''),
	CONSTRAINT Mname_not_empty check (Name != '')
GO

ALTER TABLE Client ADD
	CONSTRAINT Cname_not_empty check (Full_name != '')
GO