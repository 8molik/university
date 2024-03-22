const readline = require('readline');

const r = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function writeName(name){
    console.log(`Hello ${name}!`)
    r.close()
}

r.question("What's your name? ", (ans) => writeName(ans))