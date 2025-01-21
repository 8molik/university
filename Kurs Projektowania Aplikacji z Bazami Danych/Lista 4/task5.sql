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

--READ UNCOMMITTED � pozwala na odczyt danych, kt�re nie zosta�y jeszcze zatwierdzone, 
--                   co mo�e prowadzi� do problem�w takich jak "dirty reads".
--READ COMMITTED � transakcja mo�e odczytywa� tylko zatwierdzone dane, eliminuj�c "dirty reads", 
--				   ale nie zapobiega "non-repeatable reads" ani "phantom reads".
--REPEATABLE READ � blokuje odczytane dane, aby zapobiec ich zmianie przez inne transakcje, 
--					eliminuj�c "non-repeatable reads", ale nadal mog� wyst�powa� "phantom reads".
--SERIALIZABLE � zapewnia pe�n� izolacj� transakcji, eliminuj�c wszystkie problemy z izolacj�, 
--				 ale mo�e prowadzi� do wi�kszej liczby blokad i obni�enia wydajno�ci.

ALTER DATABASE Test SET ALLOW_SNAPSHOT_ISOLATION ON;
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
--transakcje widz� dane w wersji z chwili rozpocz�cia transakcji, 
--eliminuj�c problemy takie jak "dirty reads", "non-repeatable reads" i "phantom reads", 
--przy jednoczesnym minimalizowaniu blokad dzi�ki wersjonowaniu danych

BEGIN TRANSACTION;
INSERT INTO liczby1 (liczba) VALUES (1);

UPDATE liczby2 SET liczba = 10;


select * from liczby1
select * from liczby2