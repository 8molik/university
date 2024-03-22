#include "point.hpp"

point::point(const double &a, const double &b)
{
    x = a;
    y = b;
}

point::point(const point& other)
{
    x = other.x;
    y = other.y;
}

void point::print()
{
    std::cout << "(" << x << ", " << y << ")" << std::endl;
}

double point::getX()
{
    return x;
}
double point::getY()
{
    return y;
}

void point::move(const double &dx, const double &dy)
{
    x += dx;
    y += dy;
}

void point::rotation(const double &degree, const double &x_init, const double &y_init)
{
    if (degree > 360)
    {
        throw std::invalid_argument("Kat musi byc w zakresie od 0 do 360 stopni.");
    }
    double rad = degree * M_PI / 180.0;
    double x_prev = x;
    x = (x - x_init) * cos(rad) - (y - y_init) * sin(rad) + x_init;
    y = (x_prev - x_init) * sin(rad) + (y - y_init) * cos(rad) + y_init;
}

void point::central_symmetry()
{
    x *= -1;
    y *= -1;
}

void point::axial_symmetry(const double &a, const double &b, const double &c)
{
    if (a == 0 && b == 0 && c == 0 || a == 0 && b == 0 && c != 0)
    {
        throw std::invalid_argument("Choc jeden ze wspolczynnikow a, b prostej musi byc rozny od 0.");
    }
    double den = a * a + b * b;
    double x_new = (b * (b * x - a * y) - a * c) / den;
    double y_new = (a * (-b * x + a * y) - b * c) / den;
    x = 2 * x_new - x;
    y = 2 * y_new - y;
}