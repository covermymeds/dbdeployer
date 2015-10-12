create table #tmp(foo int);
insert into #tmp (foo) values(1);
drop table #tmp;

IF @@TRANCOUNT>0
	COMMIT;
