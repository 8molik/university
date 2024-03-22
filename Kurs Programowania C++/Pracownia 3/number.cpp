#include "number.hpp"

number::~number()
{
    delete[] history;
}

double number::get()
{
    return value;
}

void number::set(double val)
{
    history[currentIndex] = value;
    value = val;
    currentIndex = (currentIndex + 1) % maxSize;
    if (historySize < 3)
    {
        historySize += 1;
    }
}

void number::getHistory() 
{
    int start = currentIndex;
    if (historySize < 3)
    {
        for (int i = 0; i < historySize; i ++)
        {
            std::cout << history[i] << std::endl;
        }
    }
    else
    {
        for (int i = 0; i < historySize; i++)
        {
            std::cout << history[start] << std::endl;
            start = (start + 1) % historySize;
            if (start == currentIndex) 
            {
                start = (start + 1) % historySize;
            }
        }
    }
}

void number::restore() 
{
    if (historySize > 0) 
    {
        int idx = (currentIndex - 1 + maxSize) % maxSize;
        value = history[idx];
    }
} 