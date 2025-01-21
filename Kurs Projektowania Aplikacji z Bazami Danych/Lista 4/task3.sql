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
-- Ustaw poziom izolacji na Read Uncommitted, aby zezwoli� na dirty read
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Dirty Read - odczytujemy dane, zanim zostan� zatwierdzone
BEGIN TRANSACTION;
UPDATE Accounts SET AccountBalance = 700 WHERE AccountID = 3;
-- Transakcja 1 wstrzymuje si� przed zatwierdzeniem (COMMIT lub ROLLBACK).

SELECT AccountBalance FROM Accounts;
-- Wynik: 700 (nawet je�li Transakcja 1 nie zatwierdzi�a tej zmiany)

ROLLBACK;
-- Saldo konta wraca do 500
-----------------------------------------------------------------------------

-- Non-repeatable read - odczytujemy dane dwukrotnie, ale pomi�dzy odczytami inna transakcja modyfikuje dane

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN TRANSACTION;
SELECT AccountBalance FROM Accounts WHERE AccountID = 3;
-- Wynik: 500
-- Transakcja 1 wstrzymuje si� przed zako�czeniem

BEGIN TRANSACTION;
UPDATE Accounts SET AccountBalance = 700 WHERE AccountID = 3;
COMMIT;


SELECT AccountBalance FROM Accounts WHERE AccountID = 3;
-- Wynik: 700 (zmienione przez Transakcj� 2)
-- Odczyt jest niepowtarzalny, poniewa� saldo zmieni�o si� pomi�dzy odczytami
-----------------------------------------------------------------------------

-- Phantom Read - w trakcie trwania jednej transakcji, inna transakcja dodaje lub usuwa wiersze
-- kt�re spe�niaj� dany warunek, przez co pierwszy odczyt i kolejny zwracaj� r�ne zestawy danych.

BEGIN TRANSACTION;
SELECT * FROM Accounts WHERE Status = 'active';
-- Wynik: trzy rekordy
-- Transakcja 1 wstrzymuje si� przed zako�czeniem

BEGIN TRANSACTION;
INSERT INTO Accounts (AccountID, AccountBalance, Status) VALUES (4, 400, 'active');
COMMIT;

SELECT * FROM Accounts WHERE Status = 'active';
-- Wynik: cztery rekordy (Transakcja 2 doda�a nowy rekord)
-- Pojawia si� "duch" (phantom), poniewa� wynik zapytania zmieni� si� w trakcie transakcji
