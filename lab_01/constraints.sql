USE Factory
GO

ALTER TABLE Region ADD 
	CONSTRAINT pop_above_zero check (Population > 0),
	CONSTRAINT Rname_not_empty check (Name != '')
GO

alter table factory
	add constraint RegionID_FK
		foreign key (RegionID) references Region(ID)
		on delete cascade
GO

ALTER TABLE Models ADD 
	CONSTRAINT type_not_empty check (Type != ''),
	CONSTRAINT Mname_not_empty check (Name != '')
GO

alter table Factory_Models_conection add 
		constraint FactoryID_FK
			foreign key (FactoryID) references Factory(ID)
			on delete cascade, 
		constraint ModelID_FK
			foreign key (ModelID) references Models(ID)
			on delete cascade
GO

ALTER TABLE Client ADD
	CONSTRAINT Cname_not_empty check (Full_name != '')
GO

alter table OrderInfo add
		constraint ClientID_FK 
			foreign key (ClientID) references Client(ID)
			on delete cascade,
		constraint OrdModelID_FK
			foreign key (ModelID) references Models(ID)
			on delete cascade
GO

USE master
GO