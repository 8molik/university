#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;

double f(double xn, double a, int steps = 0){
    if (steps == 0){
        return xn;
    }
    else{
        return f(1.5 * xn - 0.5 * a * pow(xn, 3), a, steps - 1);
    }
}

// Środek przedziału zbieżności
double mid(double x){
    return (sqrt(1 / (3 * x)) + sqrt(5 / (3 * x))) / 2;
}

int main(){

    for (int j = 1; j < 5; j++){
        cout << "Liczba krokow: " << j << endl;
    
        for (int i = 1; i < 7; i++){
            cout << i << ": " << setw(10) << f(mid(i), i, j) << setw(10) << 1 / sqrt(i) << endl;
        }
        cout << endl;
    }
    return 0;
}