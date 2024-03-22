#include "Pixel.hpp" 

Pixel::Pixel(int x, int y)
{
    if (inRangeX(x) && inRangeY(y))
    {
        this->x = x;
        this->y = y;
    }
    else
    {
        throw std::invalid_argument("Pixel: Argument out of range");
    }
}

double Pixel::distanceToLeft()
{
    return x;
}

double Pixel::distanceToRight()
{
    return width - x - 1;
}

double Pixel::distanceToBottom()
{
    return y;
}

double Pixel::distanceToTop()
{
    return height - y - 1;
}

bool Pixel::inRangeX(int x)
{
    return (x <= width && x >= 0);
}

bool Pixel::inRangeY(int y)
{
    return (y <= height && y >= 0);
}

void Pixel::setX(int newX)
{
    if (inRangeX(newX))
    {
        this->x = newX;
    }
    else
    {
        throw std::invalid_argument("Pixel: Argument out of range");
    }
}

void Pixel::setY(int newY)
{
    if (inRangeX(newY))
    {
        this->y = newY;
    }
    else
    {
        throw std::invalid_argument("Pixel: Argument out of range");
    }
}

int Pixel::getX() const
{
    return this->x;
}

int Pixel::getY() const
{
    return this->y;
}

std::string Pixel::ToString()
{
    return "(" + std::to_string(x) + ", " + std::to_string(y) + ")";
}

int Pixel::distance(const Pixel &p, const Pixel &q)
{
    int dx = p.getX() - q.getX();
    int dy = p.getY() - q.getY();
    return std::sqrt(dx*dx + dy*dy);
}
int Pixel::distance(const Pixel *p, const Pixel *q)
{
    return distance(*p, *q);
}