function getLastProto(o) {
    var p = o;
    while(p) {
        o = p;
        p = Object.getPrototypeOf(o);
    } 
    return o;
}

var person = {
    name: 'jan'
}

var personProto = {
    surname: 'kowalski'
}

var personProto2 = {
    age: 30
}

Object.setPrototypeOf(person, personProto);
Object.setPrototypeOf(personProto, personProto2);

console.log(person.toString());
console.log(Object.getPrototypeOf(person) === Object.prototype);
console.log(getLastProto(person) === Object.prototype);
console.log(getLastProto(personProto) === Object.prototype);
console.log(getLastProto(personProto2) === Object.prototype);

