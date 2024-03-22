function fib_rec(n: number): number{
    if (n <= 1){
        return 1;
    }
    else{
        return fib_rec_m(n - 1) + fib_rec_m(n - 2);
    }
}

function memo(func: (n: number) => number): (n: number) => number {
    var cache: { [id: number]: number } = {};

    return function(n){
        if (n in cache){
            return cache[n];
        }
        else{
            var result = func(n);
            cache[n] = result;
            return result;
        }
    }
}

var fib_rec_m = memo(fib_rec);

for (let i = 0; i < 40; i++){
    console.time("memo");
    fib_rec_m(i);
    console.timeEnd("memo");
}
