//Błażej Molik
//Pracownia 1 C++
//Grupa ŁPi

#include <iostream>
#include <vector>
#include <stdexcept>

std::string bin2rzym(int x);

int main(int argc, const char* argv[])
{
    for (int i = 1; i < argc; i++)
    {
        try
        {
            std::string text_number = argv[i]; //dlaczego przypisać do zmiennej
            for (char element : text_number)
            {
                if(!isdigit(element))
                {
                    throw std::invalid_argument("Invalid argument");
                }
            }
            int number = std::stoi(argv[i]);

            if (number <= 3999 && number >= 1)
            {
                std::cout << bin2rzym(number) << std::endl;
            }
            else
            {
                throw std::out_of_range("Number out of range: ");
            }
        }
        catch (const std::invalid_argument& e) 
        {
            std::clog << "Invalid argument: " << argv[i] << std::endl;
        }
        catch (const std::out_of_range& e)
        {
            std::clog << "Number out of range: " << argv[i] << std::endl;
        }
    }
    return 0;
}

std::string bin2rzym(int x)
{
    const std::vector<std::pair<int, std::string>> rzym = 
    {
        {1000, "M"}, 
        {900, "CM"}, 
        {500, "D"}, 
        {400, "CD"}, 
        {100, "C"},
        {90, "XC"},
        {50, "L"},
        {40, "XL"},
        {10, "X"},
        {9, "IX"},
        {5, "V"},
        {4, "IV"},
        {1, "I"}
    };

    std::string result = "";
    int i = 0; 

    while (x > 0)
    {
        if (x - rzym[i].first >= 0)
        {
            x -= rzym[i].first;
            result += rzym[i].second;
        }
        else
        {
            i += 1;
        }
    }
    return result;
}
