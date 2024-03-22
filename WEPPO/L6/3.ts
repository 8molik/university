function map<T>(a: T[], f: (x: T) => T): T[] {
    if (a.length == 0) {
        return [];
    }
    else {
        return [(f(a[0])), ...map(a.slice(1), f)];
    }
}

function forEach<T>(a: T[], f: (x: T) => T): T[] {
    if (a.length == 0) {
        return [];
    }
    else {
        f(a[0]);
        return forEach(a.slice(1), f);
    }
}

function filter<T>(a: T[], f: (x: T) => boolean): T[] {
    if (a.length == 0) {
        return [];
    }
    else if (f(a[0])){
        return [a[0], ...filter(a.slice(1), f)];
    }
    else {
        return [...filter(a.slice(1), f)];
    }
}

function write<T>(x: T): T {
    console.log(x)
    return x;
}

function add1(x: number): number {
    return x + 1;
}

console.log(map([1, 2, 3, 4], add1))

forEach([1, 2, 3, 4], write)

console.log(filter([1, -10, 0, 2, 5], (x : number) => (x > 0)))