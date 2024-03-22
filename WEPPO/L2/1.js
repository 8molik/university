// Introduction
console.log("hello");

// Variables
const example = 'some string';
console.log(example);

// Arrays
const pizzaToppings = ['tomato sauce', 'cheese', 'pepperoni'];
console.log(pizzaToppings);

// If-statement
var fruit = 'orange';

if (fruit.length > 5){
    console.log('The fruit name has more than five characters.');
}
else{
    console.log('The fruit name has five characters or less.');
}

// Array-filtering
function evenNumbers (number){
    return number % 2 === 0;
}

var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
var filtered = numbers.filter(evenNumbers);
console.log(filtered);