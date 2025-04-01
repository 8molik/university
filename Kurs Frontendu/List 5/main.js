
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

/**
 * Adds a new product to the productsList.
 * @param {string} name - The name of the product.
 * @param {number} quantity - The quantity of the product.
 * @param {string} date - The date the product was bought (YYYY-MM-DD).
 * @param {boolean} status - The status of the product (true for bought, false for not bought).
 * @param {number} [price] - The price of the product (optional).
 * @returns {Product} - The newly added product.
 */
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

/**
 * Removes a product from the productsList by its ID.
 * @param {number} id - The ID of the product to remove.
 * @returns {boolean} - Returns true if the product was successfully removed, false otherwise.
 */
const removeProduct = (id) => {
    const index = productsList.findIndex(product => product.id === id);
    if (index !== -1) {
        productsList.splice(index, 1);
        return true;
    }
    return false;
}

/**
 * Edits the name of a product.
 * @param {number} id - The ID of the product.
 * @param {string} newName - The new name of the product.
 * @returns {boolean} - Returns true if the name was successfully edited, false otherwise.
 */
const editName = (id, newName) => {
    const product = productsList.find(product => product.id === id);
    if (product) {
        product.name = newName;
        return true;
    }
    return false;
}

/**
 * Edits the quantity of a product.
 * @param {number} id - The ID of the product.
 * @param {number} newQuantity - The new quantity of the product.
 * @returns {boolean} - Returns true if the quantity was successfully edited, false otherwise.
 */
const editQuantity = (id, newQuantity) => {
    const product = productsList.find(product => product.id === id);
    if (product) {
        product.quantity = newQuantity;
        return true;
    }
    return false;
}

/**
 * Edits the date of a product.
 * @param {number} id - The ID of the product.
 * @param {string} newDate - The new date of the product (YYYY-MM-DD).
 * @returns {boolean} - Returns true if the date was successfully edited, false otherwise.
 */
const editDate = (id, newDate) => {
    const product = productsList.find(product => product.id === id);
    if (product) {
        product.date = newDate;
        return true;
    }
    return false;
}

/**
 * Edits the status of a product.
 * @param {number} id - The ID of the product.
 * @param {boolean} newStatus - The new status of the product (true for bought, false for not bought).
 * @returns {boolean} - Returns true if the status was successfully edited, false otherwise.
 */
const editStatus = (id, newStatus) => {
    const product = productsList.find(product => product.id === id);
    if (product) {
        product.status = newStatus;
        return true;
    }
    return false;
}

/**
 * Swaps two products in the productsList by their IDs.
 * @param {number} id1 - The ID of the first product.
 * @param {number} id2 - The ID of the second product.
 * @returns {boolean} - Returns true if the swap was successful, false otherwise.
 */
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

/**
 * Filters products that need to be paid today but haven't been bought yet
 * @returns {Product[]} - Array of products to be paid today
 */
const toBePaidToday = () => {
    const today = new Date();
    return productsList.filter(product => !product.status && product.date === today.toISOString().split('T')[0]);
}

/**
 * Adds a price to a bought product.
 * @param {number} id - The ID of the product.
 * @param {number} price - The price to add.
 */
const addPriceToBoughtProduct = (id, price) => {
    const product = productsList.find(product => product.id === id);
    if (product.status) {
        product.price = price;
    } else {
        return false;
    }
    return true;
}

/**
 * Calculates the total price of products bought on a specific date.
 * @param {string} date - The date to check (YYYY-MM-DD).
 * @returns {number} - The total price of products bought on the specified date.
 */
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

// Example usage
const milk = addProduct("Milk", 2, "2025-04-01", false);
const bread = addProduct("Bread", 1, "2025-04-01", true, 3.5);
const butter = addProduct("Butter", 3, "2025-03-01", true);
const chicken = addProduct("Chicken", 1, "2025-04-01", true, 10);
const eggs = addProduct("Eggs", 12, "2025-04-01", false);
const beef = addProduct("Beef", 1, "2025-04-01", true, 10);

console.log("Initial products:", productsList);

editName(milk.id, "Oat Milk");
editQuantity(milk.id, 27);
editStatus(milk.id, true);
editDate(milk.id, "2025-04-15")
removeProduct(beef.id);
console.log("\n================\n")
console.log("After editing milk and removing beef:", productsList);
console.log("\n================\n")

swapProducts(milk.id, butter.id)
console.log("\n================\n")
console.log("After swapping milk and butter:", productsList);
console.log("\n================\n")

console.log("Products to buy today:", toBePaidToday());

addPriceToBoughtProduct(chicken.id, 111)
addPriceToBoughtProduct(eggs.id, 111)
console.log("\n================\n")
console.log("After adding price to chicken and eggs:", productsList);
console.log("\n================\n")

console.log("Basket price at 2025-04-01:", basketPriceAtSpecificDay("2025-04-01"))

applyFunctionToProducts([milk.id, bread.id], (product) => {product.quantity += 1})
console.log("\n================\n")
console.log("After increasing quantity for milk and bread:", productsList);
console.log("\n================\n")
