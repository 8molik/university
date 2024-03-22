function sum(...args){
    var s = 0;
    for (var i = 0; i < args.length; i++){
        s += args[i];
    }
    return s;
}

var x = sum(1, 2, 3);
console.log(x);