function fib_rec(n){
    if (n <= 1){
        return 1;
    }
    else{
        return fib_rec(n - 1) + fib_rec(n - 2);
    }
}

function memo(func){
    var cache = {}

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

var fib_rec = memo(fib_rec);   
for (let i = 0; i < 40; i++){
    console.time("memo");
    fib_rec(i);
    console.timeEnd("memo");
}
