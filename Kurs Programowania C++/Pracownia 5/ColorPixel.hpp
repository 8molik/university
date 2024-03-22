#pragma once
#include "Pixel.hpp"
#include "TransparentColor.hpp"
#include <cmath>

class ColorPixel : Pixel, TransparentColor
{
    private:
        Pixel pixel;
        TransparentColor tcolor;

    public:
        ColorPixel() : pixel(0, 0), tcolor(0, 0, 0, 255) {}
        ColorPixel(Pixel pixel, TransparentColor tcolor);
        void move(int dx, int dy);
        void setTColor(TransparentColor tcol);
        std::string ToString() override;
        rgb getR() const override;
        rgb getG() const override;
        rgb getB() const override;
        void setR(int val) override;
        void setG(int val) override;
        void setB(int val) override;
        void setX(int newX) override;
        void setY(int newY) override;
        int getX() const override; 
        int getY() const override;
};