#ifndef TRIANGLE_HPP
#define TRIANGLE_HPP

#include "point.hpp"

class triangle
{
    point a, b, c;
    public:
        triangle() {};
        triangle(const point &x, const point &y, const point &z);
        triangle(const triangle& other);
        bool is_triangle(const point &p1, const point &p2, const point &p3);
        void print();
        point getA();
        point getB();
        point getC();
        void move(const double &dx, const double &dy);
        void rotation(const double &degree, const double &x_init, const double &y_init);
        void central_symmetry();
        void axial_symmetry(const double &k, const double &l, const double &m);
        double perimeter();
        double area();
        bool in_triangle(point d);
};

#endif //TRIANGLE_HPP