USE Test;

drop table if exists liczby;
go
create table liczby ( liczba int );
go
insert liczby values ( 10 );
go

-- 1 --
--Gwarantuje, ¿e transakcja wielokrotnie odczyta te same dane bez zmian przez inne transakcje.
set transaction isolation level repeatable read;
begin transaction

-- w drugim po³¹czeniu robimy update: update liczby set liczba=4
-- ogl¹damy blokady: sp_lock

select * from liczby

-- ponownie w drugim po³¹czeniu robimy update: update liczby set liczba=4
-- ogl¹damy blokady: sp_lock

commit

-- 2 --
--Zapewnia, ¿e transakcje s¹ wykonywane tak, jakby by³y szeregowane jedna po drugiej, eliminuj¹c wszelkie wspó³bie¿ne zmiany.
set transaction isolation level serializable;

insert liczby values ( 10 );

begin transaction

-- w drugim po³¹czeniu robimy insert: insert liczby values(151)
-- ogl¹damy blokady: sp_lock

select * from liczby

-- ponownie w drugim po³¹czeniu robimy insert: insert liczby values(151)
-- ogl¹damy blokady: sp_lock

commit

--Exclusive Lock: Zapobiega jakiejkolwiek modyfikacji lub odczytowi danych przez inne transakcje podczas modyfikacji danych.

--Shared Lock: Umo¿liwia odczyt danych przez inne transakcje, ale nie pozwala na ich modyfikacjê.

--Update Lock: U¿ywana, gdy transakcja zamierza zaktualizowaæ dane, zapobiegaj¹c jednoczesnej modyfikacji przez inne transakcje.

--Intent Lock: informuj¹ system o tym, jakie blokady bêd¹ potrzebne w przysz³oœci

--Table Lock: Blokuje ca³¹ tabelê, uniemo¿liwiaj¹c jakiekolwiek modyfikacje lub odczyty przez inne transakcje