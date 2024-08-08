EXEC Staff.creation;
GO

EXEC Staff.CreateConstraintsAndRelationships;
go

EXEC dbo.CreateMasterKeyIfNotExists; 
GO

EXEC Staff.setup_insertion;
go

EXEC Staff.InsertDataFromAnotherDatabase;
go

EXEC Staff.PerformQueryTasks;
go

EXEC Staff.CreateView;
GO

EXEC Staff.CreateSpecificViews;