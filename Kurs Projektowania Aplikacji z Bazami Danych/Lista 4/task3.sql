use Test

drop table if exists Accounts
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountBalance INT,
    Status VARCHAR(10)
);

INSERT INTO Accounts (AccountID, AccountBalance, Status) VALUES 
(1, 500, 'active'),
(2, 300, 'active'),
(3, 200, 'active');

-----------------------------------------------------------------------------
-- Ustaw poziom izolacji na Read Uncommitted, aby zezwoliæ na dirty read
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Dirty Read - odczytujemy dane, zanim zostan¹ zatwierdzone
BEGIN TRANSACTION;
UPDATE Accounts SET AccountBalance = 700 WHERE AccountID = 3;
-- Transakcja 1 wstrzymuje siê przed zatwierdzeniem (COMMIT lub ROLLBACK).

SELECT AccountBalance FROM Accounts;
-- Wynik: 700 (nawet jeœli Transakcja 1 nie zatwierdzi³a tej zmiany)

ROLLBACK;
-- Saldo konta wraca do 500
-----------------------------------------------------------------------------

-- Non-repeatable read - odczytujemy dane dwukrotnie, ale pomiêdzy odczytami inna transakcja modyfikuje dane

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN TRANSACTION;
SELECT AccountBalance FROM Accounts WHERE AccountID = 3;
-- Wynik: 500
-- Transakcja 1 wstrzymuje siê przed zakoñczeniem

BEGIN TRANSACTION;
UPDATE Accounts SET AccountBalance = 700 WHERE AccountID = 3;
COMMIT;


SELECT AccountBalance FROM Accounts WHERE AccountID = 3;
-- Wynik: 700 (zmienione przez Transakcjê 2)
-- Odczyt jest niepowtarzalny, poniewa¿ saldo zmieni³o siê pomiêdzy odczytami
-----------------------------------------------------------------------------

-- Phantom Read - w trakcie trwania jednej transakcji, inna transakcja dodaje lub usuwa wiersze
-- które spe³niaj¹ dany warunek, przez co pierwszy odczyt i kolejny zwracaj¹ ró¿ne zestawy danych.

BEGIN TRANSACTION;
SELECT * FROM Accounts WHERE Status = 'active';
-- Wynik: trzy rekordy
-- Transakcja 1 wstrzymuje siê przed zakoñczeniem

BEGIN TRANSACTION;
INSERT INTO Accounts (AccountID, AccountBalance, Status) VALUES (4, 400, 'active');
COMMIT;

SELECT * FROM Accounts WHERE Status = 'active';
-- Wynik: cztery rekordy (Transakcja 2 doda³a nowy rekord)
-- Pojawia siê "duch" (phantom), poniewa¿ wynik zapytania zmieni³ siê w trakcie transakcji
