#include "ColorPixel.hpp"

ColorPixel::ColorPixel(Pixel pixel, TransparentColor tcolor)
{
    this->pixel = pixel;
    this->tcolor = tcolor;
}

void ColorPixel::move(int dx, int dy)
{
    if (inRangeX(pixel.getX() + dx) && inRangeY(pixel.getY() + dy))
        {
            pixel.setX(pixel.getX() + dx);
            pixel.setY(pixel.getY() + dy);
        }
    else
    {
        throw std::invalid_argument("ColorPixel: Argument out of range");
    }
}

void ColorPixel::setTColor(TransparentColor tcol)
{
    this->tcolor = tcolor;
}

std::string ColorPixel::ToString()
{
    return pixel.ToString() + tcolor.ToString();
}

rgb ColorPixel::getR() const
{
    return tcolor.getR();
}

rgb ColorPixel::getG() const
{
    return tcolor.getG();
}

rgb ColorPixel::getB() const
{
    return tcolor.getB();
}

void ColorPixel::setR(int val) 
{
    tcolor.setR(val);
}

void ColorPixel::setG(int val) 
{
    tcolor.setG(val);
}

void ColorPixel::setB(int val) 
{
    tcolor.setB(val);
}

void ColorPixel::setX(int val)
{
    pixel.setX(val);
}

void ColorPixel::setY(int val)
{
    pixel.setY(val);
}

int ColorPixel::getX() const
{
    return pixel.getX();
}

int ColorPixel::getY() const
{
    return pixel.getY();
}