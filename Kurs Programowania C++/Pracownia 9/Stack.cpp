#pragma once
#include "Stack.hpp"

namespace calc
{
    template<typename T>
    T& stack<T>::top()
    {
        if (empty())
        {
            throw std::out_of_range("top: Stack is empty");
        }
        return list<T>::head->value;
    }

    template<typename T>
    void stack<T>::stack_push(const T& val)
    {
        list<T>::push_front(val);
    }

    template<typename T>
    void stack<T>::stack_pop()
    {
        if (empty())
        {
            throw std::out_of_range("stack_pop: Stack is empty");
        }
        list<T>::pop_front();
    }
}