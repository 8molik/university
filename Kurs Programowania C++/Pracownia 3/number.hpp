#ifndef NUMBER_HPP
#define NUMBER_HPP

#include <iostream>

class number
{
    private:
        const int maxSize = 3;
        double value;
        double* history;
        int historySize;
        int currentIndex;

    public:
        number() : number(0) {}
        number(double val) : currentIndex(0), historySize(0), value(val), history(new double[maxSize]){}
        number(const number& other) : value(other.value), history(new double[maxSize]), historySize(0), currentIndex(0){}
        number(number&& other) noexcept : value(std::move(other.value)), history(other.history), historySize(other.historySize), currentIndex(other.currentIndex)
        {
            other.history = nullptr;
            other.historySize = 0;
        }
        ~number();
        double get();
        void set(double val);
        void getHistory();
        void restore();
};

#endif