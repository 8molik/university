#include "Color.hpp"

Color::Color(int r, int g, int b)
{
    if (inRange(r) && inRange(g) && inRange(b))
    {
        this->red = r;
        this->green = g;
        this->blue = b;
    }
    else
    {
        throw std::invalid_argument("Color: Invalid color value");
    }
}


bool Color::inRange(int x)
{
    return x <= 255 && x >= 0;
}

rgb Color::getR() const
{
    return this->red;
}

rgb Color::getG() const
{
    return this->green;
}

rgb Color::getB() const
{
    return this->blue;
}

void Color::setR(int val)
{
    if (inRange(val))
    {
        this->red = val;
    }
    else
    {
        throw std::invalid_argument("Color: Invalid color value");
    }
}

void Color::setG(int val)
{
    if (inRange(val))
    {
        this->green = val;
    }
    else
    {
        throw std::invalid_argument("Color: Invalid color value");
    }
}

void Color::setB(int val)
{
    if (inRange(val))
    {
        this->blue = val;
    }
    else
    {
        throw std::invalid_argument("Color: Invalid color value");
    }
}

void Color::brighten(int val)
{
    if (!inRange(val))
    {
        throw std::invalid_argument("Color: Invalid number");
    }
    else
    {
        red = std::min(red + val, 255);
        green = std::min(green + val, 255);
        blue = std::min(blue + val, 255);
    }
}

void Color::darken(int val)
{
    if (!inRange(val))
    {
        throw std::invalid_argument("Color: Invalid number");
    }
    else
    {
        red = std::max(red - val, 255);
        green = std::max(green - val, 255);
        blue = std::max(blue - val, 255);
    }
}

std::string Color::ToString()
{
    return "(" + std::to_string(red) + ", " + std::to_string(green) + ", " + std::to_string(blue) + ")";
}

Color Color::combine(Color col1, Color col2)
{
    Color result;
    result.setR((col1.getR() + col2.getR()) / 2);
    result.setG((col1.getG() + col2.getG()) / 2);
    result.setB((col1.getB() + col2.getB()) / 2);
    return result;
}