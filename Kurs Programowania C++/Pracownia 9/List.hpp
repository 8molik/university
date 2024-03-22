#include <stdexcept>
#include <iostream>
#include <initializer_list>

namespace calc
{
    template<typename T>
    class list
    {
        protected:
            class node
            {
                public:
                    T value;
                    node* next;         
                    node(const T& val);
            };
            node* head;
            size_t length; 
        public:
            list();
            ~list();
            list(std::initializer_list<T> values);
            list(const list& other);
            list(list&& other) noexcept;
            void insert(const T& val, size_t pos);
            void push_front(const T& val);
            void push_back(const T& val);
            void erase(size_t pos);
            void pop_front();
            void pop_back();
            void remove(const T& val);
            void remove_all(const T& val);
            size_t find(const T& val) const;
            size_t count(const T& val) const;
            size_t getSize() const;
            bool empty() const;
            template<typename U>
            friend std::ostream& operator<<(std::ostream& os, const list<U>& lst);
    };
}