#include <iostream>
#include <cmath>
#include <vector>

using namespace std;

void f1(double a, double b, double c){
    double x1 = (-b + sqrt(pow(b, 2) - 4 * a * c)) / (2.0 * a);
    double x2 = (-b - sqrt(pow(b, 2) - 4 * a * c)) / (2.0 * a);
    cout << x2 << endl;
    cout << x1 << endl;
}

void f2(double a, double b, double c){
    if (b > 0){
        double x1 = (-b - sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);
        double x2 = (2 * c) / (-b - sqrt(pow(b, 2) - 4 * a * c));
        cout << x1 << endl;
        cout << x2 << endl;
    }
    else{
        double x1 = (2 * c) / (-b + sqrt(pow(b, 2) - 4 * a * c));
        double x2 = (-b + sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);
        cout << x1 << endl;
        cout << x2 << endl;
    }
}

int main(){
    for (float i = 0; i > -100; i--){
        f1(0.000001, i, 0.000001);
        f2(0.000001, i, 0.000001);
        cout << "==========" << endl;
    }
}

/*Dla dużych |b| i małych a, c funkcja "szkolna" oblicza błędnie miejsca zerowe
problem pojawia się gdy 4ac jest bliskie 0

Poprawiona wersja korzysta z przekształconego wzoru viete
x1x2 = c/a*/