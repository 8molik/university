function createGenerator(n) {
    return function () {
        var _state = 0;

        return {
            next: function () {
                return {
                    value: _state,
                    done: _state++ >= n,
                };
            }
        };
    };
}

var foo = {
    [Symbol.iterator]: createGenerator(2),
};

var foo1 = {
    [Symbol.iterator]: createGenerator(15),
};

var foo2 = {
    [Symbol.iterator]: createGenerator(20),
};


for (var f of foo)
    console.log(f);

for (var f of foo1)
    console.log(f);