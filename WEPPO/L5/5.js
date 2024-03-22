var https = require('https')

function collectData(url) {
    return new Promise ((res, rej) =>
        https.get(url, (response) => {
            let answer = '';

            response.on('data', (data) => {
                answer += data.toString();
            });

            response.on('end', () => {
                res(answer);
            });
        })   
    )    
}

const url = 'https://en.wikipedia.org/wiki/JavaScript';

(async function main() {
    t = await collectData(url);
    console.log(t)
})()
