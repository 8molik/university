#include <iostream>
#include <cmath>

using namespace std;

double f(double x){
    return x - 0.49;
}

void bis(double a, double b){
    double s;

    for (int i = 0; i < 5; i++){
        s = (a + b) / 2.0;

        if (f(a) * f(s) < 0){
            b = s;
        }
        else{
            a = s;
        }
        cout << endl << "Krok: " << i << endl;
        cout << "Wynik: " << s << endl;
        cout << "Oszacowanie błędu: " << pow(2, -i - 1) << endl;
        cout << "Błąd rzeczywisty: " << fabs(0.49 - s) << " " << fabs(f(s)) << endl;
    }
    
}

int main(){
    double a = 0;
    double b = 1; 
    bis(a, b);

    return 0;
}

// Wyniki są poprawne, oszacowanie działa