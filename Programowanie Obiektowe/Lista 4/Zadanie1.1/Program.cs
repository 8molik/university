//Błażej Molik
//Zadanie 1, czesc 1
//.NET 7.0
//Aby uruchomić program należy otworzyć terminal w folderze i wpisać dotnet run

using NewStack;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
class Program
{
    static void Main(string[] args)
    {
        NewStack<int> stack = new NewStack<int>();

        stack.Push(1);
        stack.Push(2);
        stack.Push(3);

        Console.WriteLine("Stos przed usunięciem elementu:");
        Console.WriteLine(stack.ToString()); 
        Console.WriteLine("Wysokosc stosu: " + stack.Length());

        Console.WriteLine("Usunieto element: " + stack.Pop());

        Console.WriteLine("Stos po usunięciu elementu:");
        Console.WriteLine(stack.ToString()); 

        Console.WriteLine("Usunieto element: " + stack.Pop());
        Console.WriteLine("Usunieto element: " + stack.Pop());

        Console.WriteLine("Stos po usunięciu wszystkich elementów:");
        Console.WriteLine(stack.ToString()); 
        try
        {
            stack.Pop();
        }
        catch (InvalidOperationException e)
        {
            Console.WriteLine("Błąd: " + e.Message);
        }
    }
}
