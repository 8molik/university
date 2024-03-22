function createFs(n) { 
    var fs = []; 

    for (var i = 0; i < n; i++) {
        fs[i] = 
        ((index) => {
            return function() {
                return index;
            }
        })(i)
    };
    return fs;
}

// nawiasy powodują, że funkcja się wywołuje
var myfs = createFs(10);
console.log(myfs[0]());
console.log(myfs[2]());
console.log(myfs[7]());

// var jest widoczny również poza pętlą, w momencie w którym
// wywołujemy funkcję createFs(10) ostatnią pamiętaną wartością
// zmiennej i jest 10, zamiana var na let pozwoli za każdym nowym
// wywołaniem ystworyzć nową zmienną, widoczną w tylko w zakresie
// tej pętli. 

// Technologia Babel opiera się na translacji let i const.
// Przykładowo let x; zostanie zamienione na var _x jeżeli
// x już był wczesniej używany.