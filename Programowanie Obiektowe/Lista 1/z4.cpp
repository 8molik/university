// Błażej Molik
// Lista 1: zadanie 4
// g++ z2.cpp

#include <iostream>
#include <iomanip>

void showMatrix(float x1, float x2, float y1, float y2, float jump);

int main()
{
    std::cout << "Przykladowe wywolania: \n";
    showMatrix(0.12, 1.4, 0.1, 0.8, 0.2);
    std::cout << "------------------------------------------------------------\n";
    showMatrix(0.03, 1.4, 0.23, 0.84, 0.23);
    return 0;
}

void showMatrix(float x1, float x2, float y1, float y2, float jump)
{
    std::cout << std::setw(8) << " ";
    for (float x = x1; x < x2; x += jump)
    {
        std::cout << std::fixed << std::setw(7) << std::setprecision(4) << x;
    }
    std::cout << "\n";
    for (float j = y1; j < y2; j += jump)
    {
        std::cout << std::fixed << std::setw(7) << std::setprecision(4) << j << ":";
        for (float i = x1; i < x2; i += jump)
        {
            std::cout << std::fixed << std::setw(7) << std::setprecision(4) << i * j;
        }
        std::cout << "\n";
    }
}
