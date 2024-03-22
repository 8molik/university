#pragma once

namespace calc
{
    template<typename T>
    class queue : private list<T> 
    {
        public:
            using list<T>::list;
            using list<T>::empty;
            using list<T>::
            T& front();
            void enqueue(const T& val);
            void dequeue();
    };
}