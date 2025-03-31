
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
    if (product) {
        product.date = newDate;
        return true;
    }
    return false;
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
    return productsList.filter(product => product.status && product.date.toDateString() === today.toDateString());
}

