#include "global.hpp"

bool disjoint(triangle t1, triangle t2)
{
    if (t2.in_triangle(t1.getA()) || t2.in_triangle(t1.getA()) || t2.in_triangle(t1.getA()))
    {
        return false;
    }
    if (t1.in_triangle(t2.getA()) || t1.in_triangle(t2.getB()) || t1.in_triangle(t2.getC()))
    {
        return false;
    }
    return true;
}

bool contain(triangle t1, triangle t2)
{
    if (t2.in_triangle(t1.getA()) && t2.in_triangle(t1.getA()) && t2.in_triangle(t1.getA()))
    {
        return true;
    }
    if (t1.in_triangle(t2.getA()) && t1.in_triangle(t2.getB()) && t1.in_triangle(t2.getC()))
    {
        return true;
    }
    return false;    
}


double length(segment o)
{
    point p1 = o.getP1();
    point p2 = o.getP2();
    double d = pow((p1.getX() - p2.getX()), 2) + pow((p1.getY() - p2.getY()), 2);
    return sqrt(d);
}

bool parallel(segment o1, segment o2)
{
    double a1 = (o1.getP2().getY() - o1.getP1().getY()) / (o1.getP2().getX() - o1.getP1().getX());
    double a2 = (o2.getP2().getY() - o2.getP1().getY()) / (o2.getP2().getX() - o2.getP1().getX());
    return a1 == a2;
}

bool perpendicular(segment o1, segment o2)
{
    double a1 = (o1.getP2().getY() - o1.getP1().getY()) / (o1.getP2().getX() - o1.getP1().getX());
    double a2 = (o2.getP2().getY() - o2.getP1().getY()) / (o2.getP2().getX() - o2.getP1().getX());
    if (a2 == 0) 
    {
        return false;
    }
    else 
    {
        return a1 == -1/a2;
    }
}
