#pragma once
#include "Color.hpp"

using namespace std;

class NamedColor : virtual public Color
{
    private:
        std::string name;
        Color color;

    public:
        NamedColor() : color(0, 0, 0),  name("none") {}
        NamedColor(Color color, string name);
        virtual void setName(const string& name);
        virtual string getName() const;
        string ToString() override;
};