#pragma once
#include "List.hpp"

namespace calc
{
    template<typename T>
    class stack : private list<T> 
    {
        public:
            using list<T>::list;
            using list<T>::empty;
            T& top();
            void stack_push(const T& val);
            void stack_pop();
    };
}