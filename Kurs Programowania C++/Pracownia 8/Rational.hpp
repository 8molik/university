#include <iostream>
#include <cmath>
#include <vector> 

namespace calculations
{
    class RationalException : public std::logic_error
    {
        public:
            using std::logic_error::logic_error;
    };

    class DivisionByZeroException : public RationalException
    {
        public:
            DivisionByZeroException() : RationalException("Division by zero!") {}
    };

    class OutOfRangeException : public RationalException
    {
        public:
            OutOfRangeException() : RationalException("Out of range!") {}
    };

    int Gcd(int a, int b);

    class Rational
    {
        private: 
            int num, den;
            void shortening();
        public:
            Rational() : num(0), den(1) {}
            Rational(int num, int den = 1);
            int getNum() const;
            int getDen() const;
            std::string ToString();
            Rational operator+(const Rational& other) const;
            Rational operator-(const Rational& other) const;
            Rational operator*(const Rational& other) const;
            Rational operator/(const Rational& other) const;
            Rational operator-() const;
            Rational operator!() const;
            explicit operator double() const;
            explicit operator int() const;
            friend std::ostream& operator<< (std::ostream &out, const Rational &r);
    };
}