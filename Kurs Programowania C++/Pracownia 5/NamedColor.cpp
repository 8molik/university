#include "NamedColor.hpp"

NamedColor::NamedColor(Color color, string name)
{
    this->color = color;
    this->name = name;
}

void NamedColor::setName(const string& name)
{
    this->name = name;
}

string NamedColor::getName() const
{
    return name;
}

string NamedColor::ToString()
{
    return color.ToString() + ", " + name;
}