function Tree(val, left, right) {
    this.left = left;
    this.right = right;
    this.val = val;
}

Tree.prototype[Symbol.iterator] = function*() {
    queue = [];
    queue.push(this);

    while (queue.length > 0){
        const first = queue.shift();
        if (first.left) { 
            queue.push(first.left);
        }
        if (first.right) { 
            queue.push(first.right);
        }
        yield first.val;
    }
}

var root = new Tree(1,
    new Tree(2, new Tree(3)), new Tree(4));

for (var e of root) {
    console.log(e);
}