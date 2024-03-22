#include "TransparentColor.hpp"

TransparentColor::TransparentColor(Color color, int transparency)
{
    if (transparency < 0 || transparency > 255) 
    {
        throw std::invalid_argument("Invalid alpha value");
    }
    else
    {
        this->color = color;
        this->transparency = transparency;
    }
}

TransparentColor::TransparentColor(int r, int g, int b, int transparency)
{
    if (transparency < 0 || transparency > 255) 
    {
        throw std::invalid_argument("Invalid alpha value");
    }
    else if (!inRange(r) || !inRange(g) || inRange(b))
    {
        throw std::invalid_argument("Invalid RGB value");
    }
    else
    {
        this->color = Color(r, g, b);
        this->transparency = transparency;
    }
}

int TransparentColor::getAlpha()
{
    return transparency;
}

void TransparentColor::setAlpha(const int& val)
{
    if (val < 0 || val > 255) 
    {
        throw std::invalid_argument("Invalid alpha value");
    }
    else
    {
        transparency = val;
    }
}

std::string TransparentColor::ToString()
{
    return color.ToString() + ", " + std::to_string(transparency);
}

rgb TransparentColor::getR() const
{
    return color.getR();
}

rgb TransparentColor::getG() const
{
    return color.getG();
}

rgb TransparentColor::getB() const
{
    return color.getB();
}

void TransparentColor::setR(int val)
{
    if (inRange(val))
    {
        color.setR(val);
    }
    else
    {
        throw std::invalid_argument("Color: Invalid color value");
    }
}

void TransparentColor::setG(int val)
{
    if (inRange(val))
    {
        color.setG(val);
    }
    else
    {
        throw std::invalid_argument("Color: Invalid color value");
    }
}

void TransparentColor::setB(int val)
{
    if (inRange(val))
    {
        color.setB(val);
    }
    else
    {
        throw std::invalid_argument("Color: Invalid color value");
    }
}