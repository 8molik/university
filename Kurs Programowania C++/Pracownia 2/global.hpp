#ifndef GLOBAL_HPP
#define GLOBAL_HPP

#include "triangle.hpp"
#include "segment.hpp"

bool disjoint(triangle, triangle t2);
bool contain(triangle t1, triangle t2);
double length(segment o);
bool parallel(segment o1, segment o2);
bool perpendicular(segment o1, segment o2);

#endif //GLOBAL_HPP