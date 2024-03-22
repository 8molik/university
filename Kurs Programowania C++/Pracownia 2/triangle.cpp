#include "triangle.hpp"
#include "global.hpp"

triangle::triangle(const point &x, const point &y, const point &z)
{
    a = x;
    b = y;
    c = z;
    if (!is_triangle(x, y, z))
    {
        throw std::invalid_argument("Nie mozna utworzyc trojkata");
    }
}

triangle::triangle(const triangle& other)
{
    a = other.a;
    b = other.b;
    c = other.c;
}

bool triangle::is_triangle(const point &p1,const point &p2, const point &p3) 
{
    double a = length(segment(p1, p2));
    double b = length(segment(p2, p3));
    double c = length(segment(p3, p1));
    return (a + b > c) && (b + c > a) && (c + a > b);
}

point triangle::getA()
{
    return a;
}

point triangle::getB()
{
    return b;
}

point triangle::getC()
{
    return c;
}

void triangle::print()
{
    a.print();
    b.print(); 
    c.print();
}

void triangle::move(const double &dx, const double &dy)
{
    a.move(dx, dy);
    b.move(dx, dy);
    c.move(dx, dy);
}

void triangle::rotation(const double &degree, const double &x_init, const double &y_init)
{
    a.rotation(degree, x_init, y_init);
    b.rotation(degree, x_init, y_init);
    c.rotation(degree, x_init, y_init);
}

void triangle::central_symmetry()
{
    a.central_symmetry();
    b.central_symmetry();
    c.central_symmetry();
}

void triangle::axial_symmetry(const double &k, const double &l, const double &m)
{
    a.axial_symmetry(k, l, m);
    b.axial_symmetry(k, l, m);
    c.axial_symmetry(k, l, m);
}

double triangle::perimeter()
{
    return length(segment(a, b)) + length(segment(b, c)) + length(segment(c, a));
}

double triangle::area()
{
    return 0.5 * abs((b.getX() - a.getX()) * (c.getY() - a.getY()) - (b.getY() - a.getY()) * (c.getX() - a.getX()));
}

bool triangle::in_triangle(point d)
{
    double AB = (b.getY() - a.getY()) * (d.getX() - a.getX()) - (b.getX() - a.getX()) * (d.getY() - a.getY());
    double BC = (c.getY() - b.getY()) * (d.getX() - b.getX()) - (c.getX() - b.getX()) * (d.getY() - b.getY());
    double CA = (a.getY() - c.getY()) * (d.getX() - c.getX()) - (a.getX() - c.getX()) * (d.getY() - c.getY());
    return (AB >= 0 && BC >= 0 && CA >= 0) || (AB <= 0 && BC <= 0 && CA <= 0);
}