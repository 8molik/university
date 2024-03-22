#pragma once
#include "NamedColor.hpp"
#include "TransparentColor.hpp"
#include "Color.hpp"

class NTColor : NamedColor, TransparentColor
{
    private:
        Color color;
        int transparency;
        string name;

    public:
        NTColor() : color(0, 0, 0), transparency(255), name("none") {}
        NTColor(Color color, int transparency, string name);
        string getName() const override;
        void setName(const string& name) override;
        int getAlpha() override;
        void setAlpha(const int& val) override;
        void setColor(const Color& color);
        Color getColor();
        std::string ToString() override;
};