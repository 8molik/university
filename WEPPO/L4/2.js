var person = {
    name: 'jan'
}

var personProto = {
    surname: 'kowalski',
    age: 30
}

Object.setPrototypeOf(person, personProto);

// zwraca true, jeżeli zawiera takie pole
function isInObject(obj, propertyName) {
    return obj.hasOwnProperty(propertyName);
}

// Wypisuje pola, również te z łańcucha prototypów
for (key in person) {
    console.log(key);
}

for (key in person) { 
    if(isInObject(person, key)) {
        console.log(key);
    }
}

// Object.keys
