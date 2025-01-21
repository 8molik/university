set nocount on

drop table if exists liczby
go
create table liczby( nr int primary key, liczba int )
go
declare @a int
set @a=1
while ( @a<=60)
begin
  insert liczby values ( @a, @a )
  set @a=@a+1
end
go

declare @x int
set @x=10

-- Do wykonania 3 razy (ka¿de z osobna, analizujemy wyniki: results i messages)
declare c cursor for select liczba from liczby where liczba<=@x
--declare c cursor static for select liczba from liczby where liczba<=@x
--declare c cursor keyset for select liczba from liczby where liczba<=@x

set @x=20

open c

declare @aux int, @licznik int
set @licznik=2

print 'Kolejne liczby z kursora:'
fetch next from c into @aux 
while ( @@fetch_status=0 )
begin
  print @aux;
  print 'Liczba: '+cast(@aux as varchar)
  print 'Licznik: '+cast(@licznik as varchar)
  delete from liczby where liczba=@licznik
  fetch next from c into @aux 
  set @licznik=@licznik+2
end
print 'Status ostatniej instrukcji fetch: ' + cast(@@fetch_status as varchar)
close c
deallocate c

select * from liczby where liczba<=10

--Kursor domyœlny (Dynamiczny): Odruchowo uwzglêdnia zmiany w danych, co oznacza, 
--¿e wiersze mog¹ siê zmieniaæ podczas przetwarzania kursora.

--Kursor statyczny: Tworzy zrzut danych w momencie otwarcia, co oznacza, ¿e nie uwzglêdnia ¿adnych zmian w danych po jego otwarciu.

--Kursor oparty na kluczach: Utrzymuje zbiór kluczy dla wierszy i pozwala na 
--aktualizacjê istniej¹cych wierszy, ale nie pokazuje nowych wierszy dodanych po otwarciu kursora.
-- mo¿e widzieæ kolumny niekluczowe