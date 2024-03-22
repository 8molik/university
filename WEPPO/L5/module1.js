module.exports = { test1 } 
const b = require('./module2.js')
console.log('Module 1 loaded module 2')

function test1(x){
    if (x > 0){
        console.log(`Module 1: ${x}`)
        b.test2(x - 1)
    }
}
