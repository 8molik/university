#pragma once
#include "Color.hpp"

class TransparentColor : virtual public Color
{
    private:
        Color color;
        int transparency;
    
    public:
        TransparentColor() : color(0, 0, 0), transparency(255) {}
        TransparentColor(Color color, int transparency);
        TransparentColor(int r, int g, int b, int transparency);
        virtual int getAlpha();
        virtual void setAlpha(const int& val);
        std::string ToString() override;
        rgb getR() const override;
        rgb getG() const override;
        rgb getB() const override;
        void setR(int val) override;
        void setG(int val) override;
        void setB(int val) override;
};
