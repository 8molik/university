//Błażej Molik
//Zadanie 1 czesc 2
//.NET 7.0
//Aby uruchomić program należy otworzyć terminal w folderze i wpisać dotnet run

using System;
using NewLinkedList;

namespace LinkedListTest
{
    class Program
    {
        static void Main(string[] args)
        {
            LinkedListNew<int> list = new LinkedListNew<int>();

            list.PushBack(1);
            list.PushBack(2);
            list.PushBack(3);
            list.PushFront(0);

            Console.WriteLine("Lista po dodaniu elementów:");
            Console.WriteLine(list.ToString()); 

            list.PopFront();
            list.PopBack();

            Console.WriteLine("Lista po usunięciu elementów:");
            Console.WriteLine(list.ToString()); 

            Console.WriteLine("Czy lista jest pusta: " + list.isEmpty()); 

            list.PopFront();
            list.PopBack();

            Console.WriteLine("Lista po usunięciu wszystkich elementów:");
            Console.WriteLine(list.ToString()); 

            Console.WriteLine("Czy lista jest pusta: " + list.isEmpty());
        }
    }
}
