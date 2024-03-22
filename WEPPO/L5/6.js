const readline = require('readline');
const fs = require('fs');

function processLines2() {
    return new Promise((res, rej) => {
        const file = fs.createReadStream('6.log');
        let lines = [];
        
        const r = readline.createInterface({
            input: file
        });

        r.on('line', (line) => {
            lines.push(line.split(' '));
        });

        r.on('close', () => {
            res(lines);
        });
    });
}

function sortObject(obj) {
    return Object.keys(obj).map(k => ([k, obj[k]])).sort((a, b) => (b[1] - a[1]))
}

(async function main() {
    var t = await processLines2();
    var adressessDict = {}
    
    for (line of t){
        if (line[0] in adressessDict) {
            adressessDict[line[0]] += 1;
        }
        else {
            adressessDict[line[0]] = 1;
        }
    }
    console.log(sortObject(adressessDict).slice(0, 3));
})()


// Wersja 2
/*async function processLines() {
    const file = fs.createReadStream('6.log');
    let lines = [];
    var adressessDict = {};

    const r = readline.createInterface({
        input: file
    });
    for await (const line of r) {
        line = line.split(' ');
        if (line[0] in adressessDict) {
            adressessDict[line[0]] += 1;
        }
        else {
            adressessDict[line[0]] = 1;
        }
    }
}*/

