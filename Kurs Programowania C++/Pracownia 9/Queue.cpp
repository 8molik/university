#include "Queue.hpp"

namespace calc
{   
    template<typename T>
    T& queue<T>::front()
    {
        if (empty())
        {
            throw std::out_of_range("front: Queue is empty");
        }
        else
        {
            return list<T>::head->value;
        }
    }

    template<typename T>
    void queue<T>::enqueue(const T& val)
    {
        list<T>::push_back(val);
    }

    template<typename T>
    void queue<T>::dequeue()
    {
        if (empty())
        {
            throw std::out_of_range("dequeue: Queue is empty");
        }
        list<T>::pop_front();
    }
}