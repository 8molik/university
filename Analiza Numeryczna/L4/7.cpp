#include <iostream>
#include <cmath>

using namespace std;

double f(double xn, double a, int steps){
    if (steps == 0){
        return xn;
    }
    else{
        return f(0.5 * xn + 0.5 * a * 1.0 / xn, a, steps - 1);
    }
}

double mid(double a){
    return (-a / 3.0 + a) / 2.0;
}

int main(){
    int c = 5;
    double m = 1.0/2.0;
    
    if(c % 2 == 0){
        for (int i = -50; i < 50; i ++)
            cout << i << ": " << pow(2, c / 2) * f(i, m, 6) << endl;
    }
    else{
        for (int i = -50; i < 50; i ++)
            cout << i << ": " << pow(2, c / 2) * f(i, 2 * m, 6) << endl;
    }

    return 0;
}