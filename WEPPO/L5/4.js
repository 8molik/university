var fs = require('fs');

function read() {
    return new Promise((res, rej) => {
        fs.readFile('text.txt', 'utf-8', (err, answer) => {
            if (err) {
                rej(answer);
            }
            else{
                res(answer);
            }
        })
    });
};

(async function main() {
    t = await read()
    console.log(t)
})()