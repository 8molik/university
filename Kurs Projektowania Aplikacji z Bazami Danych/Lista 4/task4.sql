USE Test;

drop table if exists liczby;
go
create table liczby ( liczba int );
go
insert liczby values ( 10 );
go

-- 1 --
--Gwarantuje, �e transakcja wielokrotnie odczyta te same dane bez zmian przez inne transakcje.
set transaction isolation level repeatable read;
begin transaction

-- w drugim po��czeniu robimy update: update liczby set liczba=4
-- ogl�damy blokady: sp_lock

select * from liczby

-- ponownie w drugim po��czeniu robimy update: update liczby set liczba=4
-- ogl�damy blokady: sp_lock

commit

-- 2 --
--Zapewnia, �e transakcje s� wykonywane tak, jakby by�y szeregowane jedna po drugiej, eliminuj�c wszelkie wsp�bie�ne zmiany.
set transaction isolation level serializable;

insert liczby values ( 10 );

begin transaction

-- w drugim po��czeniu robimy insert: insert liczby values(151)
-- ogl�damy blokady: sp_lock

select * from liczby

-- ponownie w drugim po��czeniu robimy insert: insert liczby values(151)
-- ogl�damy blokady: sp_lock

commit

--Exclusive Lock: Zapobiega jakiejkolwiek modyfikacji lub odczytowi danych przez inne transakcje podczas modyfikacji danych.

--Shared Lock: Umo�liwia odczyt danych przez inne transakcje, ale nie pozwala na ich modyfikacj�.

--Update Lock: U�ywana, gdy transakcja zamierza zaktualizowa� dane, zapobiegaj�c jednoczesnej modyfikacji przez inne transakcje.

--Intent Lock: informuj� system o tym, jakie blokady b�d� potrzebne w przysz�o�ci

--Table Lock: Blokuje ca�� tabel�, uniemo�liwiaj�c jakiekolwiek modyfikacje lub odczyty przez inne transakcje