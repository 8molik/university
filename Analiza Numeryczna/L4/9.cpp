#include <iostream>
#include <cmath>

using namespace std;

// f(x) = (x - 5) ^ 3

double a = 5;
int r = 3;

double f(double x){
    return pow(x - a, r);
}

double f_(double x){
    return r * pow(f(x - a), (r - 1));
}

double newton(double xn, int steps){
    if (steps == 0){
        return xn;
    }
    else{
        return newton(xn - (r * f(xn) / f_(xn)), steps - 1);
    }
}

int main(){
    for (int i = 1; i < 11; i++)
        cout << newton(i, 10) << endl;
}