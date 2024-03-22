#include "number.cpp"

int main() 
{
    number a(1.23);

    number y;
    std::cout << "Konstruktor domyslny: " << y.get() << std::endl;

    number z(a);
    std::cout << "Konstruktor kopiujacy: " << z.get() << std::endl;

    number w(number(4.56));
    std::cout << "Konstuktor przenoszacy: " << w.get() << std::endl;

    // Przypisanie kopiujące
    number copy = a;
    std::cout << "Kopia zmiennej a: " << copy.get() << std::endl;

    // Przypisanie przenoszące
    number move = std::move(a);
    std::cout << "Zmienna x po przeniesieniu: " << a.get() << std::endl;
    std::cout << "Zmienna po przeniesieniu: " << move.get() << std::endl;
    
    number x(1.23);
    std::cout << "Wartosc startowa: " << x.get() << std::endl;

    x.restore();
    std::cout << "Przywrocona liczba: " << x.get() << std::endl;

    x.set(2.34);
    std::cout << "Dodano: " << x.get() << std::endl;

    std::cout << "-------------------------" << std::endl;
    std::cout << "Obecna historia: " << std::endl;
    x.getHistory();
    std::cout << "Obecna wartosc: " << x.get() << std::endl;
    std::cout << "-------------------------" << std::endl;

    x.set(4.56);
    std::cout << "Dodano: " << x.get() << std::endl;
    x.set(5.67);
    std::cout << "Dodano: " << x.get() << std::endl;

    std::cout << "-------------------------" << std::endl;
    std::cout << "Obecna historia: " << std::endl;
    x.getHistory();
    std::cout << "Obecna wartosc: " << x.get() << std::endl;
    std::cout << "-------------------------" << std::endl;

    x.restore();
    std::cout << "Przywrocona liczba: " << x.get() << std::endl;
    
    std::cout << "-------------------------" << std::endl;
    std::cout << "Obecna historia: " << std::endl;
    x.getHistory();
    std::cout << "Obecna wartosc: " << x.get() << std::endl;
    std::cout << "-------------------------" << std::endl;
}