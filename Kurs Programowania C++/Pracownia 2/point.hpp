#ifndef POINT_HPP
#define POINT_HPP

#include <iostream>
#include <cmath>
#include <stdexcept>

class point
{
double x, y;

public:
    point() {};
    point(const double &a, const double &b);
    point(const point& other);
    void print();
    double getX();
    double getY();
    void move(const double &dx, const double &dy);
    void rotation(const double &degree, const double &x_init, const double &y_init);
    void central_symmetry();
    void axial_symmetry(const double &a, const double &b, const double &c);
};

#endif //POINT_HPP