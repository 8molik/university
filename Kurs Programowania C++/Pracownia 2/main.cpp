#include "point.hpp"
#include "segment.hpp"
#include "triangle.hpp"
#include "global.hpp"
#include <iomanip>
#include <iostream>

int main()
{
    try
    {   
        std::cout << "==============================================" << std::endl;

        point p = point(-2, 3);
        std::cout << "Punkt startowy: ";
        p.print();
        p.rotation(180, 0 , 0);
        std::cout << "Obrot o 180 stopni, wzgledem srodka: ";
        p.print();
        p.move(2, 4);
        std::cout << "Przesuniecie o wektor (2, 4): ";
        p.print();
        p.central_symmetry();
        std::cout << "Symetria wzgledem srodka: ";
        p.print();
        p.axial_symmetry(1, -1, 0);
        std::cout << "Symetria wzgledem prostej y=x: ";
        p.print();

        std::cout << "==============================================" << std::endl;
        
        segment o = segment(point(1, 1), point (4, 4));
        std::cout << "Odcinek startowy: ";
        o.print();
        o.move(2, -3);
        std::cout << "Przesuniecie o wektor (2, -3): ";
        o.print();
        o.rotation(180, 0, 0);
        std::cout << "Obrot o 180 stopni, wzgledem srodka: ";
        o.print();
        o.central_symmetry();
        std::cout << "Symetria wzgledem srodka: ";
        o.print();
        o.axial_symmetry(1, -1, 0);
        std::cout << "Symetria wzgledem prostej y=x: ";
        o.print();
        std::cout << "Dlugosc odcinka: " << length(o) << std::endl;
        o.print();
        std::cout << "Czy punkt (2, 1) nalezy do odcinka: " << o.in_segment(point (2, 1)) << std::endl;
        std::cout << "Czy punkt (-2, 3) nalezy do odcinka: " << o.in_segment(point (-2, 3)) << std::endl;

        segment o1 = segment(point(1, 1), point(2, 2));
        segment o2 = segment(point(2, 2), point(3, 3));
        segment o3 = segment(point(-1, 1), point(-2, 2));

        std::cout << "Czy odcinki: " << std::endl;
        o1.print();
        o2.print();
        std::cout << "sa rownolegle? " << parallel(o1, o2) << std::endl;

        std::cout << "Czy odcinki: " << std::endl;
        o1.print();
        o3.print();
        std::cout << "sa prostopadle? " << perpendicular(o3, o1) << std::endl;
      
        std::cout << "==============================================" << std::endl;

        point p1 = point (2, 3);
        point p2 = point (0, 0);
        point p3 = point (2, 0);

        point q1 = point (0, 0);
        point q2 = point (3, 5);
        point q3 = point (3, 0);

        triangle t1 = triangle(p1, p2, p3);
        triangle t2 = triangle(q1, q2, q3);
        
        std::cout << "Wspolrzedne trojkata 1: " << std::endl;
        t1.print();
        std::cout << "Pole powierzchni: " << t1.area() << std::endl;
        std::cout << "Obwod: " << t1.perimeter() << std::endl;
        std::cout << "Czy punkt (1, 1) nalezy do trojkata: " << t1.in_triangle(point(1, 1)) << std::endl;

        std::cout << "Wspolrzedne trojkata 2: " << std::endl;
        t2.print();
        std::cout << "Czy t1 zawiera sie w t2: " << contain(t1, t2) << std::endl;
        std::cout << "Czy t1 i t2 sa rozlaczne: " << disjoint(t1, t2) << std::endl;
    
        std::cout << "==============================================" << std::endl;

        p.rotation(361, 0, 0);
        p.axial_symmetry(0, 0, 0);
        segment s = segment(point(0, 0), point(0, 0));
        triangle t = triangle(point(0, 1), point(0, 0), point(0,2));
    }
    catch(const std::exception& e)
    {
        std::clog << e.what() << '\n';
    }
    return 0;
}