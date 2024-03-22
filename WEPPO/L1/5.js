function fibRecursive(n){
    if (n == 0){
        return 0;
    }
    else if (n == 1){
        return 1;
    }
    else{
        return fibRecursive(n - 1) + fibRecursive(n - 2);
    }
}

function fibIterative(n){
    let prev1 = 0;
    let prev2 = 0;
    let curr = 1;

    for (let i = 1; i < n; i++){
        prev1 = curr;
        curr = prev1 + prev2;
        prev2 = prev1;
    }
    return curr;
}

function main(){
    for (let i = 0; i < 40; i++){
        console.log(i)
        console.time("iterative");
        fibIterative(i);
        console.timeEnd("iterative");
    
        console.time("recursive");
        fibRecursive(i);
        console.timeEnd("recursive");
    }
}

main()