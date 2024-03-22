const fs = require('fs');
const util = require('util')

// stara wersja
fs.readFile('text.txt', 'utf-8', function (err, data) {
    if (err) {
        console.error(err);
      } 
      else {
        console.log(data[0]);
      }
});

// promise
function f1() {
    return new Promise (function(res, rej) {
        fs.readFile('text.txt', 'utf-8', function(err, data) {
            if (err){
                rej(data);
            }
            else{
                res(data);
            }
        })
    })
}

// po nowemu
(async function f1_() {
    var ans = await f1();
    console.log(ans[0]);
})() // samowywołanie


// util ===================================

const utilText = util.promisify(fs.readFile);   

utilText('text.txt', 'utf-8')
    .then((text) => {
        console.log(text[0])
    })
    .catch((err) => {
        console.log(err)
    })


// fs promises ==================================

const fsPromises = fs.promises;
// po staremu
fsPromises.readFile('text.txt', 'utf-8')
   .then(data => {
        console.log(data[0]);
    })
    .catch(err => {
        console.log(err);
    })

