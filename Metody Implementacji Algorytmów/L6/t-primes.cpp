#include <iostream>
#include <cmath>
#define ll long long

using namespace std;

const int limit = 1000005;
int primes[limit];

void sieve(){
    primes[0] = 1;
    primes[1] = 1;
    for(int i = 2; i * i <= limit; i++){
        if (primes[i] == 0) {
            for (int j = i * i; j <= limit; j += i){
                primes[j] = 1;
            }
        }
    }
}


int main(){
    int n;
    cin >> n;

    sieve();

    for (int i = 0; i < n; i++){
        ll a;
        cin >> a;

        ll sa = sqrt(a);

        if (sa * sa == a && !primes[sa]){
            cout << "YES" << endl;
        }
        else{
            cout << "NO" << endl;
        }
    }   
}