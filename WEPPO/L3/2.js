function forEach(a, f){
    if (a.length == 0){
        return [];
    }
    else{
        f(a[0]);
        forEach(a.slice(1), f);
    }
}

function map(a, f){
    if (a.length == 0){
        return [];
    }
    else{
        return [(f(a[0])), ...map(a.slice(1), f)];
    }
}

function filter(a, f){
    if (a.length == 0){
        return [];
    }
    else if (f(a[0])){
        return [a[0], ...filter(a.slice(1), f)]
    }
    else{
        return [...filter(a.slice(1), f)]
    }
}

var xs = [1, 2, 3, 4];
(forEach(xs, x => console.log(x)));
console.log(map(xs, x => x * x));
console.log(filter(xs, x => x < 3))