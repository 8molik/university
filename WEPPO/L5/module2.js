module.exports = { test2 }
const a = require('./module1.js')
console.log('Module 2 loaded module 1')

function test2(x){
    if (x > 0){
        console.log(`Module 2: ${x}`)
        a.test1(x - 1)
    }
}
