// Błażej Molik
// Lista 1: zadanie 2
// g++ z2.cpp

#include <iostream>
#include <numeric>

typedef struct {
    int num; //licznik
    int den; //mianownik
} Ulamek;

void show(Ulamek *u);
Ulamek* shortening(Ulamek *u);
Ulamek* addition(Ulamek *u1, Ulamek *u2);
Ulamek* substraction(Ulamek *u1, Ulamek *u2);
Ulamek* multiplication(Ulamek *u1, Ulamek *u2);
Ulamek* division(Ulamek *u1, Ulamek *u2);
Ulamek* mnozenie(Ulamek *u1, Ulamek *u2);
Ulamek* dodawanie(Ulamek *u1, Ulamek *u2);
Ulamek* odejmowanie(Ulamek *u1, Ulamek *u2);
Ulamek* dzielenie(Ulamek *u1, Ulamek *u2);
int Gcd(int a, int b);

int main()
{ 
    Ulamek u1 = {1, 2};
    Ulamek u2 = {2, 4};
    Ulamek u3 = {1, 3};

    show(shortening(&u2));
    show(shortening(addition(&u3, &u2)));
    show(division(&u3, &u2));
    show(multiplication(&u3, &u2));
    show(substraction(&u3, &u2));

    show(shortening(dodawanie(&u1, &u2)));   

    return 0;
}


//Funkcja wyświetlająca wartość ułamka
void show(Ulamek *u)
{
    std::cout << u->num << "/" << u->den << '\n';
}

int Gcd(int a, int b) 
{
    int tmp;
    while (b != 0) {
        tmp = b;
        b = a % b;
        a = tmp;
    }
    return a;
}

//Funkcja skracająca ułamek
//Poprawka: funkcja nie zwraca już nowej zmiennej, ale modyfikuje podany ulamek
Ulamek* shortening(Ulamek *u)
{
    int nwd = Gcd(u->num, u->den); //Znajduje nwd licznika i mianownika
    u->num = u->num/nwd; // do nowoutworzonej zmiennej ulamek przypisuje skrocone wartosci
    u->den = u->den/nwd;
    return u;
}

//Funkcje, które mają angielskie nazwy zwracają wskaźnik na nowo utworzony element
Ulamek* addition(Ulamek *u1, Ulamek *u2)
{
    Ulamek *result= new Ulamek;

    result->num = u1->num * u2->den + u2->num * u1->den;
    result->den = u1->den * u2->den;
    
    return result;
}

Ulamek* substraction(Ulamek *u1, Ulamek *u2)
{
    Ulamek *result= new Ulamek;
    
    result->num = u1->num * u2->den - u2->num * u1->den;
    result->den = u1->den * u2->den;

    return result;
}

Ulamek* multiplication(Ulamek *u1, Ulamek *u2)
{
    Ulamek *result= new Ulamek;

    result->num = u1->num * u2->num;
    result->den = u1->den * u2->den;
    
    return result;
}

Ulamek* division(Ulamek *u1, Ulamek *u2)
{
    Ulamek *result= new Ulamek;

    result->num = u1->num * u2->den;
    result->den = u2->num * u1->den;
    
    return result;
}

//Funkcje, które mają polskie nazwy modyfikują pierwszy ułamek
Ulamek* mnozenie(Ulamek *u1, Ulamek *u2)
{
    u1->num = u1->num * u2->num;
    u1->den = u1->den * u2->den;
    
    return u1;
}

Ulamek* dodawanie(Ulamek *u1, Ulamek *u2)
{
    u1->num = u1->num * u2->den + u2->num * u1->den;
    u1->den = u1->den * u2->den;
    
    return u1;
}

Ulamek* odejmowanie(Ulamek *u1, Ulamek *u2)
{
    u1->num = u1->num * u2->den - u2->num * u1->den;
    u1->den = u1->den * u2->den;
    
    return u1;
}

Ulamek* dzielenie(Ulamek *u1, Ulamek *u2)
{
    u1->num = u1->num * u2->den;
    u1->den = u2->num * u1->den;
    
    return u1;
}


