#include <iostream>
#include <iomanip>
#include "Rational.hpp"

using namespace calculations;
void print(std::string s, Rational x);

int main()
{
    Rational r1(1, 2);
    print("r1: ", r1);
    Rational r2(2, 3);
    print("r2: ", r2);

    Rational r3 = r1 + r2;
    print("r1 + r2: ", r3);

    Rational r4 = r1 - r2;
    print("r1 - r2: ", r4);

    Rational r5 = r1 * r2;
    print("r1 * r2: ", r5);

    Rational r6 = r1 / r2;
    print("r1 / r2: ", r6);

    Rational r7 = -r1;
    print("-r1: ", r7);

    Rational r8 = !r1;
    print("!r1: ", r8);

    double d = static_cast<double>(r1);
    std::cout << d << std::endl;

    int i = static_cast<int>(r1);
    std::cout << i << std::endl; 

    Rational r9(r1);
    std::cout << r9 << std::endl; 

    Rational r10(r2);
    std::cout << r10 << std::endl; 

    r1 = Rational(3, 4);
    std::cout << r1 << std::endl; 

    std::cout << r9 << std::endl;

    return 0;
}

void print(std::string s, Rational x)
{
    std::cout << std::left << std::setw(12) << s << std::setw(5) << x.ToString() << std::setw(3) << "=";
    std::cout << x << std::endl;
}
