function fibIterator() {
    let a = 0;
    let b = 1;

    return {
        next: 
        function() {
            const val = b;
            const tmp = a + b;
            a = b;
            b = tmp;

            return {
                value: val,
                done: false
            }
        }
    }
}

function* fibGenerator(){
    let a = 0;
    let b = 1;

    while(true) { 
        yield b;
        const tmp = a + b; // let == const dlaczego?
        a = b;
        b = tmp;
    }
}

function* take(it, top) {
    let i = 1;
    for (var x; x = it.next(), i <= top;) {
        yield x.value;
        i += 1;
    }
}

it = fibGenerator()
for (var res; res = it.next(), res.value < 100;){
    console.log(res.value)
}


for (let num of take(fibIterator(), 10)) {
    console.log(num);
}

for (let num of take(fibGenerator(), 10)) {
    console.log(num);
} // czemu to działa?  
