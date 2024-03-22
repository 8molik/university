function divisible(number) {
    const digits = Array.from(String(number), Number);
    let s = 0;

    for (let i = 0; i < digits.length; i++){
        s += digits[i];
    }
    if (number % s == 0){
        for (let i = 0; i < digits.length; i++){
            if (number % digits[i] != 0){
                return false;
            }
            else{
                continue;
            }
        }
    }
    else{
        return false;
    }
    return true;
}

function generateNumbers(){
    const result = [];
    for (let i = 1; i < 100000; i++){
        if (divisible(i)){
            result.push(i);
        }
    }
    console.log(result);
}

generateNumbers();