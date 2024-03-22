const readline = require('readline');

var r = readline.createInterface(process.stdin, process.stdout);

var question = function(q) {
    return new Promise((res, rej) => {
        r.question(q, answer => {
            res(answer);
        })
    });
};

function getRandomInt(max) {
    return Math.floor(Math.random() * max);
  }

(async function main() {
    var answer;
    const number = getRandomInt(100);
    answer = await question('Enter number between 1 and 100: ')
    while (answer != number) {
        if (answer < number){
            answer = await question('Try something bigger: ');
        }        
        else if (answer > number){
            answer = await question('Try something smaller: ');
        }       
    }
    console.log("You are correct!");
    r.close();
})();