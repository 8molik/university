#include "List.hpp"

namespace calc 
{
    template<typename T>
    list<T>::node::node(const T& val) : value(val), next(nullptr) {}

    template<typename T>
    list<T>::list() : head(nullptr), length(0) {}

    template<typename T>
    list<T>::~list() 
    {
        while (!empty()) 
        {
            pop_front();
        }
    }

    template<typename T>
    list<T>::list(std::initializer_list<T> values) : list() 
    {
        for (const auto& val : values) 
        {
            push_back(val);
        }
    }

    template<typename T>
    list<T>::list(const list& other) : head(nullptr), length(0)
    {
        node* current = other.head;
        while (current != nullptr)
        {
            push_back(current->value);
            current = current->next;
        }
    }

    template<typename T>
    list<T>::list(list&& other) noexcept : head(other.head), length(other.length)
    {
        other.head = nullptr;
        other.length = 0;
    }

    template<typename T>
    void list<T>::insert(const T& val, size_t pos)
    {
        if (pos > length)
        {
            throw std::out_of_range("insert: Invalid index");
        }
        else if (pos == 0)
        {
            push_front(val);
        }
        else if (pos == length)
        {
            push_back(val);
        }
        else
        {
            node* new_node = new node(val);
            node* curr = head;
            size_t i = 0;
            while (i != pos - 1)
            {
                curr = curr->next;
                i++;
            }
            new_node->next = curr->next;
            curr->next = new_node;
            length++;
        }
    }

    template<typename T>
    void list<T>::push_front(const T& val)
    {
        node* new_node = new node(val);
        new_node->next = head;
        head = new_node;
        length++;
    }

    template<typename T>
    void list<T>::push_back(const T& val)
    {
        if (length == 0)
        {
            push_front(val);
        }
        else
        { 
            node* new_node = new node(val);
            node* curr = head;
            while (curr->next)
            {
                curr = curr->next;
            }
            curr->next = new_node;
            length++;
        }
    }

    template<typename T>
    void list<T>::erase(size_t pos)
    {
        if (pos >= length)
        {
            throw std::out_of_range("erase: Invalid index");
        }

        if (pos == 0)
        {
            pop_front();
            return;
        }

        node* prev = nullptr;
        node* curr = head;
        size_t i = 0;
        while (i != pos)
        {  
            prev = curr;
            curr = curr->next;
            i++;
        }
        prev->next = curr->next;
        delete curr;
        length--;
    }

    template<typename T> 
    void list<T>::pop_front()
    {
        if (length == 0)
        {
            throw std::out_of_range("pop_front: Empty list");
        }
        node* del_node = head;
        head = head->next;
        delete del_node;
        length--;
    }

    template<typename T> 
    void list<T>::pop_back()
    {
        if (length == 0)
        {
            throw std::out_of_range("pop_back: Empty list");
        }

        if (length == 1)
        {
            pop_front();
            return;
        }

        node* prev = nullptr;
        node* curr = head;
        while (curr->next)
        {
            prev = curr;
            curr = curr->next;
        }
        prev->next = nullptr;
        delete curr;
        length--;
    }

    template<typename T>
    void list<T>::remove(const T& val)
    {
        node* prev = nullptr;
        node* curr = head;
        while(curr)
        {
            if (curr->value == val)
            {
                if (prev)
                    prev->next = curr->next;
                else
                    head = curr->next;

                node* temp = curr;
                curr = curr->next;
                delete temp;
                length--;
            }
            else
            {
                prev = curr;
                curr = curr->next;
            }
        }
    }

    template<typename T>
    void list<T>::remove_all(const T& val)
    {
        node* prev = nullptr;
        node* curr = head;
        while(curr)
        {
            if (curr->value == val)
            {
                if (prev) prev->next = curr->next;
                else head = curr->next;
                delete curr;
                length--;
            }
            prev = curr;
            curr = curr->next;
        }
    }

    template<typename T>
    size_t list<T>::find(const T& val) const 
    {
        node* curr_node = head;
        size_t pos = 0;
        while (curr_node) 
        {
            if (curr_node->value == val) 
            {
                return pos;
            }
            curr_node = curr_node->next;
            pos++;
        }
        return static_cast<size_t>(-1);
    }

    template<typename T>
    size_t list<T>::count(const T& val) const 
    {
        size_t count = 0;
        node* curr_node = head;
        while (curr_node) {
            if (curr_node->value == val) 
            {
                count++;
            }
            curr_node = curr_node->next;
        }
        return count;
    }

    template<typename T>
    size_t list<T>::getSize() const 
    {
        return length;
    }

    template<typename T>
    bool list<T>::empty() const 
    {
        return length == 0;
    }

    template<typename U>
    std::ostream& operator<<(std::ostream& os, const list<U>& lst)
    {
        typename list<U>::node* curr = lst.head;
        while (curr)
        {
            os << curr->value << " ";
            curr = curr->next;
        }
        return os;
    }
}