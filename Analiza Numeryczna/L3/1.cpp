#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;

float a1(float x){
    return 1.0 / (pow(x, 3) + sqrt(pow(x, 6) + pow(2023, 2)));
}

float a2(float x){
    return (sqrt(pow(x, 6) + pow(2023, 2)) - pow(x, 3)) / pow(2023, 2);
}

float b1(float x){
    return log2(x) - 2;
}

double b2(double x){
    return log(x/4.0) / log(2.0);
}

double b3(double x){
    return log2(x/4.0);
}

double c1(double x){
    return pow(x, -3) * (- x + atan(x));
}

double c3(double x){
    int j = 2;
    double s1 = - 1.0 / 3.0;

    for (double i = 2; i < 100; i += 2){
        s1 += pow(-1, j) * pow(x, i) / (i + 3.0);
        j += 1;
    }
    return s1;
}

int main(){

    cout << "a1: " << a1(1000) << endl;
    cout << "a2: " << a2(1000) << endl; //wolfram: 0.00000005
    cout << "a1: " << a1(-1000) << endl;
    cout << "a2: " << a2(-1000) << endl; //wolfram: 488.704
    cout << b1(4.002312) << endl;
    cout << b2(4.002312) << endl; //wolfram: 0.000833637
    cout << b3(4.002312) << endl;
    cout << "=========" << endl;
    
    cout << c1(0.001) << endl;
    cout << c3(0.001) << endl;
    cout << setprecision(10) << c1(0.86000012343) << endl;
    cout << c3(0.86000012343) << endl;
}