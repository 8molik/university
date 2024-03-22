#pragma once
#include <iostream>
#include <cmath>
class Pixel
{
    private:
        int x, y;
        static const int height = 1080;
        static const int width = 1920;
    public:
        Pixel() : x(0), y(0) {}
        Pixel(int x, int y);
        double distanceToLeft();
        double distanceToRight();
        double distanceToBottom();
        double distanceToTop();
        bool inRangeX(int x);
        bool inRangeY(int y);
        virtual void setX(int newX);
        virtual void setY(int newY);
        virtual int getX() const; 
        virtual int getY() const;
        virtual std::string ToString();
        static int distance(const Pixel &p, const Pixel &q);
        static int distance(const Pixel *p, const Pixel *q);
};