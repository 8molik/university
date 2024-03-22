#include "segment.hpp"

segment::segment(const point &a, const point &b)
{
    p1 = a;
    p2 = b;
    if (p1.getX() == p2.getX() and p1.getY() == p2.getY())
    {
        throw std::invalid_argument("Nie mozna utworzyc odcinka o lengthi 0");
    }
}

segment::segment(const segment& other)
{
    p1 = other.p1;
    p2 = other.p2;
}

void segment::print()
{
    std::cout << "(" << p1.getX() << ", " << p1.getY() << "), (" << p2.getX() << ", " << p2.getY()<< ")" << std::endl;
}

point segment::getP1()
{
    return p1;
}

point segment::getP2()
{
    return p2;
}

bool segment::in_segment(point c)
{
    double epsilon = 0.005;
    double x1 = p1.getX();
    double y1 = p1.getY();
    double x2 = p2.getX();
    double y2 = p2.getY();

    if (abs((y2 - y1) * c.getX() - (x2 - x1) * c.getY() + x2 * y1 - y2 * x1) / sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1)) < epsilon)
    {
        if ((c.getX() > x1 - epsilon && c.getX() < x2 + epsilon) || (c.getX() < x1 + epsilon && c.getX() > x2 - epsilon))
        {
            if ((c.getY() > y1 - epsilon && c.getY() < y2 + epsilon) || (c.getY() < y1 + epsilon && c.getY() > y2 - epsilon))
            {
                return true;
            }
        }
    }
    return false;
}

void segment::move(const double &dx, const double &dy)
{
    p1.move(dx, dy);
    p2.move(dx, dy);
}

void segment::central_symmetry()
{
    p1.central_symmetry();
    p2.central_symmetry();
}
void segment::axial_symmetry(const double &a, const double &b, const double &c)
{
    p1.axial_symmetry(a, b, c);
    p2.axial_symmetry(a, b, c);
}

void segment::rotation(const double &degree, const double &x_init, const double &y_init)
{
    p1.rotation(degree, x_init, y_init);
    p2.rotation(degree, x_init, y_init);
}
