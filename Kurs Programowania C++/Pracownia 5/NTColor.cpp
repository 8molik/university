#include "NTColor.hpp"

NTColor::NTColor(Color color, int transparency, string name)
{
    this->color = color;
    this->transparency = transparency;
    this->name = name;
}

string NTColor::getName() const
{
    return this->name;
}

void NTColor::setName(const string& name)
{
    this->name = name;
}

int NTColor::getAlpha()
{
    return transparency;
}

void NTColor::setAlpha(const int& val)
{
    if (val < 0 || val > 255) 
    {
        throw std::invalid_argument("NTColor: Invalid alpha value");
    }
    else
    {
        transparency = val;
    }
}

void NTColor::setColor(const Color& color)
{
    this->color = color;
}

Color NTColor::getColor()
{
    return this->color;
}

std::string NTColor::ToString()
{
    return color.ToString() + ", " + std::to_string(transparency) + ", " + name;
}