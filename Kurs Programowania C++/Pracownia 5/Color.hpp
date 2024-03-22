#pragma once
#include <iostream>

typedef unsigned char rgb;

class Color
{
    private:
        int red, green, blue;
    public:
        Color() : red(0), green(0), blue(0) {}
        Color(int red, int green, int blue);
        bool inRange(int x);
        virtual rgb getR() const;
        virtual rgb getG() const;
        virtual rgb getB() const;
        virtual void setR(int val);
        virtual void setG(int val);
        virtual void setB(int val);
        void brighten(int val);
        void darken(int val);
        virtual std::string ToString();
        static Color combine(Color col1, Color col2);
};
