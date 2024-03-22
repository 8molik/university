var n = 1;

console.log(typeof Object.getPrototypeOf(n));

var x = {
    bar: 12
}

Object.setPrototypeOf(n, x);

n.foo = 'foo';
console.log(n.foo);
console.log(n.bar);



// Nie można dodawać prototypów do typów prostych,
// funkcja z 3 linijki zwraca 'object' ponieważ wynika to z 
// charakterystyki JS, w którym liczby są tymczasowo konwerotwane
// na obiekty, w celu dostępu do ich prototypów.

// Przykład - wywołanie metody toString na zmiennej m
var m = true;
console.log(m.toString());