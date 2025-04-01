
/**
 * @typedef {Object} Product
 * @property {number} id - The unique identifier for the product.
 * @property {string} name - The name of the product.
 * @property {number} quantity - The quantity of the product.
 * @property {Date} date - The date the product was bought.
 * @property {boolean} status - The status of the product (true for bought, false for not bought).
 * @property {number} [price] - The price of the product (optional).
 * 
 */

/**
 * @type {Product[]} productsList
 */
let productsList = []

const addProduct = (name, quantity, date, status, price) => { 
    const id = Math.floor(Math.random() * 1000000);
    const product = { 
        id, 
        name, 
        quantity, 
        date, 
        status, 
        price: status ? price : undefined};
    productsList.push(product);
    return product;
}

const removeProduct = (id) => {
    const index = productsList.findIndex(product => product.id === id);
    if (index !== -1) {
        productsList.splice(index, 1);
        return true;
    }
    return false;
}

const editName = (id, newName) => {
    const product = productsList.find(product => product.id === id);
    if (product) {
        product.name = newName;
        return true;
    }
    return false;
}

const editQuantity = (id, newQuantity) => {
    const product = productsList.find(product => product.id === id);
    if (product) {
        product.quantity = newQuantity;
        return true;
    }
    return false;
}

const editDate = (id, newDate) => {
    const product = productsList.find(product => product.id === id);
    const date = new Date(newDate);

    const isValidDate = (date) => {
        return date instanceof Date && !isNaN(date.getTime());
    };

    if (product && isValidDate(date)) {
        product.date = newDate;
        return true;
    } else {
        throw "Unsupported data format! (YYYY-MM-DD)";
    }
}

const editStatus = (id, newStatus) => {
    const product = productsList.find(product => product.id === id);
    if (product) {
        product.status = newStatus;
        return true;
    }
    return false;
}

const swapProducts = (id1, id2) => {
    const index1 = productsList.findIndex(product => product.id === id1);
    const index2 = productsList.findIndex(product => product.id === id2);
    if (index1 !== -1 && index2 !== -1) {
        const temp = productsList[index1];
        productsList[index1] = productsList[index2];
        productsList[index2] = temp;
        return true;
    }
    return false;
}

const toBePaidToday = () => {
    const today = new Date();
    return productsList.filter(product => !product.status && product.date === today.toISOString().split('T')[0]);
}

const addPriceToBoughtProduct = (id, price) => {
    const product = productsList.find(product => product.id === id);
    if (product.status) {
        product.price = price;
    } else {
        return false;
    }
    return true;
}

const basketPriceAtSpecificDay = (date) => {
    const totalPrice = productsList.reduce((acc, product) => {
        if (product.status && product.date === date) {
            return acc + (product.price || 0);
        }
        return acc
    }, 0);
    return totalPrice;
}

const applyFunctionToProducts = (ids, tFunction) => {
    productsList.forEach(product => {
        if (ids.includes(product.id)) {
            tFunction(product)
        }
    })
}


const testProduct1 = addProduct("Milk", 2, "2025-04-01", false);
const testProduct2 = addProduct("Bread", 1, "2025-04-01", true, 3.5);
const testProduct3 = addProduct("Butter", 3, "2025-03-01", true);
const testProduct4 = addProduct("Chicken", 1, "2025-04-01", true, 10);
const testProduct5 = addProduct("Beef", 1, "2025-04-01", true, 10);

console.log("Initial products:", productsList);

editName(testProduct1.id, "Oat Milk");
editQuantity(testProduct1.id, 27);
editStatus(testProduct1.id, true);
editDate(testProduct1.id, "2025-04-15")
removeProduct(testProduct5.id);

console.log("\n================\n")
console.log("After editing and removal:", productsList);
console.log("\n================\n")


swapProducts(testProduct1.id, testProduct3.id)
console.log("\n================\n")
console.log("After swapping:", productsList);
console.log("\n================\n")

console.log("Products to buy today:", toBePaidToday());


addPriceToBoughtProduct(testProduct4.id, 111)
addPriceToBoughtProduct(testProduct3.id, 111)
console.log("\n================\n")
console.log("After swapping:", productsList);
console.log("\n================\n")


console.log(basketPriceAtSpecificDay("2025-04-01"))

applyFunctionToProducts([testProduct1.id, testProduct2.id], (product) => {product.quantity += 1})

console.log(productsList)