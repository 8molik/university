use Test2
drop table if exists liczby1;
drop table if exists liczby2;
create table liczby1 ( liczba int )
create table liczby2 ( liczba int )
go

commit 
rollback
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--READ UNCOMMITTED – pozwala na odczyt danych, które nie zosta³y jeszcze zatwierdzone, 
--                   co mo¿e prowadziæ do problemów takich jak "dirty reads".
--READ COMMITTED – transakcja mo¿e odczytywaæ tylko zatwierdzone dane, eliminuj¹c "dirty reads", 
--				   ale nie zapobiega "non-repeatable reads" ani "phantom reads".
--REPEATABLE READ – blokuje odczytane dane, aby zapobiec ich zmianie przez inne transakcje, 
--					eliminuj¹c "non-repeatable reads", ale nadal mog¹ wystêpowaæ "phantom reads".
--SERIALIZABLE – zapewnia pe³n¹ izolacjê transakcji, eliminuj¹c wszystkie problemy z izolacj¹, 
--				 ale mo¿e prowadziæ do wiêkszej liczby blokad i obni¿enia wydajnoœci.

ALTER DATABASE Test SET ALLOW_SNAPSHOT_ISOLATION ON;
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
--transakcje widz¹ dane w wersji z chwili rozpoczêcia transakcji, 
--eliminuj¹c problemy takie jak "dirty reads", "non-repeatable reads" i "phantom reads", 
--przy jednoczesnym minimalizowaniu blokad dziêki wersjonowaniu danych

BEGIN TRANSACTION;
INSERT INTO liczby1 (liczba) VALUES (1);

UPDATE liczby2 SET liczba = 10;


select * from liczby1
select * from liczby2