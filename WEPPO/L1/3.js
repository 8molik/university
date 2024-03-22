function sieve(number){
    const primes = [];
    const isPrime = Array(number).fill(true);

    isPrime[0] = false;
    isPrime[1] = false;

    for (let i = 2; i < number; i++){
        for (let j = i * i; j < number; j += i){
            isPrime[j] = false;
        }
    }

    for (let i = 0; i < number; i++){
        if (isPrime[i] == true){
            primes.push(i);
        }
    }
    return primes;
}

console.log(sieve(100000));