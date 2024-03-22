var Person = function(name) {
    this.name = name;
}
var Worker = function(name, age) { 
    Person.call(this, name);
    this.age = age
}

Person.prototype.say = function() {
    console.log(this.name);
}

var p = new Person('jan');
p.say();

Worker.prototype = Object.create( Person.prototype );
var w = new Worker('jakub', 20);
w.say();

// Błędne podejście:
Worker.prototype = Person.prototype;
// modyfikując worker.prototype, dodając metodę
// dodajemy ją zarówno do worker.prototype jak i do person.prototype
// zmiany w dziedziczącym Person pojawiają się w klasie nadrzędnej

// Błędne podejście:
Worker.prototype = new Person();
// Tworzymy nowy obiekt person
// wywołujemy jego konstruktor