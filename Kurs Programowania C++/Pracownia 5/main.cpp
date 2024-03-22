#include "Color.cpp"
#include "TransparentColor.cpp"
#include "NamedColor.cpp"
#include "NTColor.cpp"
#include "Pixel.cpp"
#include "ColorPixel.cpp"

int main()
{
    try {
        Color example(123, 42, 240);
        std::cout << "Przykladowy kolor: " << example.ToString() << std::endl;

        example.setB(123);
        std::cout << "Kolor po ustawieniu wartosci B: " << example.ToString() << std::endl;

        Color red(255, 0, 0);
        Color green(0, 255, 0); 
        std::cout << "Polaczenie czerwonego i zielonego " << Color::combine(red, green).ToString() << std::endl;
        
        std::cout << "===================================" << std::endl;
        TransparentColor tcolor(example, 230);
        std::cout << "Kolor transparentny: " << tcolor.ToString() << std::endl;
        
        tcolor.setAlpha(0);
        std::cout << "Zmiana alfy na 0: " << tcolor.ToString() << std::endl;

        std::cout << "===================================" << std::endl;
        NamedColor ncolor(red, "czerwony");
        std::cout << "Kolor nazwany: " << tcolor.ToString() << std::endl;
        std::cout << "Nazwa koloru: " << ncolor.getName() << std::endl;

        std::cout << "===================================" << std::endl;
        NTColor ntcolor(red, 234, "czerwony");
        std::cout << "Kolor nazwany i transparetny: " << ntcolor.ToString() << std::endl;
        ntcolor.setName("niebieski");;
        ntcolor.setColor(Color(123, 123, 123));
        std::cout << "Po zmianie nazwy i alfy: " << ntcolor.ToString() << std::endl;

        std::cout << "===================================" << std::endl;
        Pixel pixel(1200, 123);
        std::cout << "Przykladowy pixel: " << pixel.ToString() << std::endl;
        pixel.setX(1234);
        std::cout << "Zmiana wspolrzednej x: " << pixel.ToString() << std::endl;

        ColorPixel cpixel (pixel, tcolor);
        std::cout << "Pixel kolorowy: " << cpixel.ToString() << std::endl;
        cpixel.move(100, -100);
        std::cout << "Pixel kolorowy po przesunieciu: " << cpixel.ToString() << std::endl;
        
        std::cout << "Dystans pomiedzy pixelami: ";
        std::cout << Pixel::distance(Pixel(1334, 123), Pixel(1234, 123)) << std::endl;

        cpixel.setR(2344);
        cpixel.setX(4444);
        example.setR(1234);
    }
    catch (const std::invalid_argument& e)
    {
        std::cerr << e.what() << std::endl;
    }
    return 0;
}
