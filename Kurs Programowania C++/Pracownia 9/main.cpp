#include "List.cpp"
#include "Queue.cpp"
#include "Stack.cpp"

int main() {
    try 
    {
        // Tworzenie listy i dodawanie elementów
        calc::list<int>* myList = new calc::list<int>();
        myList->push_back(1);
        myList->push_back(2);
        myList->push_front(3);
        std::cout << "List: " << *myList << std::endl;

        // Tworzenie stosu i dodawanie elementów
        calc::stack<double>* myStack = new calc::stack<double>();
        myStack->stack_push(4);
        myStack->stack_push(2);
        myStack->stack_push(6);
        std::cout << "Stack: ";
        while (!myStack->empty())
        {
            std::cout << myStack->top() << " ";
            myStack->stack_pop();
        }
        std::cout << std::endl;

        // Tworzenie kolejki i dodawanie elementów
        calc::queue<std::string>* myQueue = new calc::queue<std::string>();
        myQueue->enqueue("Hello");
        myQueue->enqueue("World");
        myQueue->enqueue("!");
        std::cout << "Queue: ";
        while (!myQueue->empty()) {
            std::cout << myQueue->front() << " ";
            myQueue->dequeue();
        }
        std::cout << std::endl;

        // Usuwanie utworzonych obiektów
        delete myList;
        delete myStack;
        delete myQueue;
    } 
    catch (const std::exception& e) 
    {
        std::cout << "Exception occurred: " << e.what() << std::endl;
    }
    
    return 0;
}
