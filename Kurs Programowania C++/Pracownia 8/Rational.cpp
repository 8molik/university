#include "Rational.hpp"

namespace calculations
{
    int Gcd(int a, int b)
    {
        return b == 0 ? a : Gcd(b, a % b);
    }

    Rational::Rational(int num, int den)
    {
        if (den == 0)
        {
            throw DivisionByZeroException();
        }
        else if (num > INT_MAX || num < INT_MIN || den > INT_MAX || den < INT_MIN)
        {
            throw OutOfRangeException();
        }
        else
        {
            this->num = num;
            this->den = den;
            shortening();
        }
    }

    void Rational::shortening()
    {
        int gcd = Gcd(num, den);

        this->num /= gcd;
        this->den /= gcd;
    }

    int Rational::getNum() const
    {
        return this->num;
    }

    int Rational::getDen() const
    {
        return this->den;
    }

    std::string Rational::ToString()
    {
        if (num < 0 || den < 0)
        {
            return "-" + std::to_string(std::abs(num)) + "/" + std::to_string(std::abs(den));
        }
        else
        {
            return std::to_string(num) + "/" + std::to_string(den);
        }
    }

    Rational Rational::operator+(const Rational& other) const 
    {
        int new_num = num * other.den + other.num * den;
        int new_den = other.den * den;

        if (new_num > INT_MAX || new_num < INT_MIN || new_den > INT_MAX || new_den < INT_MIN)
        {
            throw OutOfRangeException();
        }

        return Rational(new_num, new_den);
    }

    Rational Rational::operator-(const Rational& other) const 
    {
        int new_num = num * other.den - other.num * den;
        int new_den = other.den * den;

        if (new_num > INT_MAX || new_num < INT_MIN || new_den > INT_MAX || new_den < INT_MIN)
        {
            throw OutOfRangeException();
        }

        return Rational(new_num, new_den);
    }

    Rational Rational::operator*(const Rational& other) const 
    {
        int new_num = num * other.num;
        int new_den = other.den * den;

        if (new_num > INT_MAX || new_num < INT_MIN || new_den > INT_MAX || new_den < INT_MIN)
        {
            throw OutOfRangeException();
        }

        return Rational(new_num, new_den);
    }

    Rational Rational::operator/(const Rational& other) const 
    {
        int new_num = num * other.den;
        int new_den = den * other.num;

        if (new_num > INT_MAX || new_num < INT_MIN || new_den > INT_MAX || new_den < INT_MIN)
        {
            throw OutOfRangeException();
        }
        else if (new_den == 0)
        {
            throw DivisionByZeroException();
        }

        return Rational(new_num, new_den);
    }

    Rational Rational::operator-() const 
    {
        return Rational((-1) * num, den);
    }

    Rational Rational::operator!() const 
    {
        if (num == 0)
        {
            throw DivisionByZeroException();
        }

        return Rational(den, num);
    }


    Rational::operator double() const
    {
        return static_cast<double>(num) / static_cast<double>(den);
    }

    Rational::operator int() const
    {
        return static_cast<int>(std::round(num/den));
    }

    std::ostream& operator << (std::ostream &out, const Rational &r)
    {
        std::vector<int> remainders;
        std::vector<int> results;
        int remainder;

        if (r.num < 0 || r.den < 0)
        {
            out << "-";
        }

        remainder = r.num % r.den;
        if (remainder == 0)
        {
            out << r.num / r.den;
            return out;
        }
        
        remainders.push_back (remainder);
        out << std::abs(r.num / r.den) << ".";

        while (true)
        {
            results.push_back(std::abs(remainder * 10 / r.den));
            remainder = remainder * 10 % r.den;

            if (remainder == 0) //ulamek jest skonczony
            {
                for (int i = 0; i < results.size(); i++)
                {
                    out << results[i];
                }
                return out;
            }

            for (int i = 0; i < remainders.size(); i++)
            {
                if (remainder == remainders[i])
                {
                    for (int j = 0; j < i; j++)
                    {
                        out << results[j];
                    }
                    out << "(";
                    for (int j = i; j < results.size(); j++)
                    {
                        out << results[j];
                    }
                    out << ")";
                    return out;
                }
            }
            remainders.push_back(remainder);
        }
    }
}