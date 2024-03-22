#ifndef SEGMENT_HPP
#define SEGMENT_HPP

#include "point.hpp"

class segment
{
    point p1, p2;
    public:
        segment(const point &a, const point &b);
        segment(const segment& other);
        void print();
        point getP1();
        point getP2();
        bool in_segment(point c);
        void move(const double &dx, const double &dy);
        void rotation(const double &degree, const double &x_init, const double &y_init);
        void central_symmetry();
        void axial_symmetry(const double &a, const double &b, const double &c);
};
#endif //SEGMENT_HPP