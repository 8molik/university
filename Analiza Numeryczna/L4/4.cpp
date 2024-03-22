#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;

double f(double x){
    return pow(x, 4) - log(x + 4.0);
} 

// Miejsca przecięcia wykresu f(x) = x^2 oraz g(x) = ln(x + 4)
// będą miejscami zerowymi funkcji ich różnicy

double bis(double a, double b, double epsilon){
    double s = (a + b) / 2.0;

    while (fabs(b - a) > epsilon){
        if (f(a) * f(s) < 0){
            b = s;
        }
        else{
            a = s;
        }
        s = (a + b) / 2.0;
    }
    return s;
}

int main(){
    cout << fixed << setprecision(10) << bis(-2, 0, pow(10, -8)) << endl;
    cout << fixed << setprecision(10) << bis(0, 2, pow(10, -8)) << endl;
    return 0;
}