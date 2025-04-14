// Wyzwanie 1
console.log(capitalize("alice"));

function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

// Wyzwanie 2
function capitalizeSentence(sentence) {
  return sentence
    .split(" ")
    .map((word) => capitalize(word))
    .join(" ");
}

console.log(capitalizeSentence("alice"));
console.log(capitalizeSentence("alice in wonderland"));

// Wyzwanie 3
const ids = [];
const generateId = () => {
  let id = 0;
  do {
    id++;
  } while (ids.includes(id));

  ids.push(id);
  return id;
};

console.time("generateId");

for (let i = 0; i < 3000; i++) {
  generateId();
}

console.timeEnd("generateId");
console.time("generateId2");

const ids2 = new Set();
const generateId2 = () => {
  let id = 0;
  do {
    id++;
  } while (ids2.has(id));

  ids2.add(id);
  return id;
};

for (let i = 0; i < 3000; i++) {
  generateId2();
}

console.timeEnd("generateId2");

// Wyzwanie 4
const compareObjects = (obj1, obj2) => {
  if (
    typeof obj1 !== "object" ||
    typeof obj2 !== "object" ||
    obj1 === null ||
    obj2 === null
  ) {
    return obj1 === obj2;
  }

  const keys1 = Object.keys(obj1);
  const keys2 = Object.keys(obj2);

  if (keys1.length !== keys2.length) {
    return false;
  }

  for (let i = 0; i < keys1.length; i++) {
    if (!keys2.includes(keys1[i])) {
      return false;
    }
    if (!compareObjects(obj1[keys1[i]], obj2[keys1[i]])) {
      return false;
    }
  }

  return true;
};

const obj1 = {
  name: "Alice",
  age: 25,
  address: {
    city: "Wonderland",
    country: "Fantasy",
  },
};

const obj2 = {
  name: "Alice",
  age: 25,
  address: {
    city: "Wonderland",
    country: "Fantasy",
  },
};

const obj3 = {
  age: 25,
  address: {
    city: "Wonderland",
    country: "Fantasy",
  },
  name: "Alice",
};

const obj4 = {
  name: "Alice",
  age: 25,
  address: {
    city: "Not Wonderland",
    country: "Fantasy",
  },
};

const obj5 = {
  name: "Alice",
};

console.log("Should be True:", compareObjects(obj1, obj2));
console.log("Should be True:", compareObjects(obj1, obj3));
console.log("Should be False:", compareObjects(obj1, obj4));
console.log("Should be True:", compareObjects(obj2, obj3));
console.log("Should be False:", compareObjects(obj2, obj4));
console.log("Should be False:", compareObjects(obj3, obj4));
console.log("Should be False:", compareObjects(obj1, obj5));
console.log("Should be False:", compareObjects(obj5, obj1));

// Wyzwanie 5
let library = [];

const addBookToLibrary = (title, author, pages, isAvailable, ratings) => {
  if (typeof title !== "string" || title.trim() === "") {
    throw new Error("title powinien być niepustym napisem");
  }
  if (typeof author !== "string" || author.trim() === "") {
    throw new Error("author powinien być niepustym napisem");
  }
  if (typeof pages !== "number" || pages <= 0 || !Number.isInteger(pages)) {
    throw new Error("pages powinna być dodatnią liczbą całkowitą");
  }
  if (typeof isAvailable !== "boolean") {
    throw new Error("isAvailable powinno być wartością typu boolean");
  }
  if (!Array.isArray(ratings)) {
    throw new Error("ratings powinna być tablicą");
  }
  if (
    ratings.length > 0 &&
    !ratings.every(
      (rating) => typeof rating === "number" && rating >= 0 && rating <= 5
    )
  ) {
    throw new Error("ratings powinna zawierać liczby między 0 a 5");
  }

  library.push({
    title,
    author,
    pages,
    available: isAvailable,
    ratings,
  });
};

// Wyzwanie 6
const testAddingBooks = (testCases) => {
  testCases.forEach(({ testCase, shouldFail }, index) => {
    try {
      addBookToLibrary(...testCase);
      if (shouldFail) {
        console.log("Test failed:", testCase);
      } else {
        console.log("Test passed:", testCase);
      }
    } catch (e) {
      if (shouldFail) {
        console.log("Test passed:", testCase);
        console.log("Expected failure:", e.message);
      } else {
        console.log("Test failed:", testCase, e.message);
      }
    }
  });
};

const testCases = [
  { testCase: ["", "Author", 200, true, []], shouldFail: true },
  { testCase: ["Title", "", 200, true, []], shouldFail: true },
  { testCase: ["Title", "Author", -1, true, []], shouldFail: true },
  { testCase: ["Title", "Author", 200, "yes", []], shouldFail: true },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3, 6]], shouldFail: true },
  {
    testCase: ["Title", "Author", 200, true, [1, 2, 3, "yes"]],
    shouldFail: true,
  },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3, {}]], shouldFail: true },
  { testCase: ["Title", "Author", 200, true, []], shouldFail: false },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3]], shouldFail: false },
  { testCase: ["Title", "Author", 200, true, [1, 2, 3, 4]], shouldFail: false },
  {
    testCase: ["Title", "Author", 200, true, [1, 2, 3, 4, 5]],
    shouldFail: false,
  },
];

testAddingBooks(testCases);

// Wyzwanie 7
const addBooksToLibrary = (books) => {
  books.forEach((args) => addBookToLibrary(...args));
};

const books = [
  ["Alice in Wonderland", "Lewis Carroll", 200, true, [1, 2, 3]],
  ["1984", "George Orwell", 300, true, [4, 5]],
  ["The Great Gatsby", "F. Scott Fitzgerald", 150, true, [3, 4]],
  ["To Kill a Mockingbird", "Harper Lee", 250, true, [2, 3]],
  ["The Catcher in the Rye", "J.D. Salinger", 200, true, [1, 2]],
  ["The Hobbit", "J.R.R. Tolkien", 300, true, [4, 5]],
  ["Fahrenheit 451", "Ray Bradbury", 200, true, [3, 4]],
  ["Brave New World", "Aldous Huxley", 250, true, [2, 3]],
  ["The Alchemist", "Paulo Coelho", 200, true, [1, 2]],
  ["The Picture of Dorian Gray", "Oscar Wilde", 300, true, [4, 5]],
];

addBooksToLibrary(books);
console.log(library);
