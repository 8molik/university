// 1. Użycie operatorów . oraz [] do odwoływania się do składowych obiektu.

// – Jakie są różnice między tymi dwoma sposobami?
const person = {
    name: "Jakub",
    age: 20
};
console.log(person.age);

const Age = 'age';
console.log(person[Age]);

// Operator . moze być użyty gdy nazwa nie zawiera spacji
// Operator [] pozwala na użycie zmiennych jako nazwy właściwości

// 2. Użycie argumentów innego typu niż string dla operatora [] dostępu do składowej obiektu.

// - Co się dzieje jeśli argumentem operatora jest liczba?
const person2 = {
    1: "Jakub",
    2: 20
};

console.log(person2[1]);

// - Co się dzieje jeśli argumentem operatora jest inny obiekt?
const key = {
    prop: "1"
};

console.log(person2[key.prop]);

// Oba przypadki działają, 
// Programista ma pełną kontrolę nad kluczem

// 3. Użycie argumentów innego typu niż number dla operatora [] dostępu do tablicy
// - Co się dzieje jeśli argumentem operatora jest napis?
const fruits = ["apple", "orange", "banana"];
console.log(fruits["1"]);
// Działa (XD)

// - Co się dzieje jeśli argumentem operatora jest inny obiekt?
const key2 = {
    prop: "1"
};

console.log(fruits[key2.prop]);
// Działa

// - Czy i jak zmienia się zawartość tablicy jeśli zostanie do niej dopisana właściwość
// pod kluczem, który nie jest liczbą?
const fruits2 = ["apple", "orange", "banana"];
fruits2["2"] = "strawberry";
console.log(fruits2);
// Chyba nie działa

// -Czy można ustawiać wartość atrybutu length tablicy na inną wartość niż liczba
// elementów w tej tablicy? Co się dzieje jeśli ustawia się wartość mniejszą niż liczba
// elementów, a co jeśli ustawia się wartość większą niż liczba elementów?

fruits.length = 10;
console.log(fruits.length)

fruits.length = 2;
console.log(fruits.length)
// Działa