using System;
using System.Collections.Generic;

namespace Zadanie3
{
    class Program
    {
        static void Main(string[] args)
        {
            LazyIntList intList = new LazyIntList();
            Console.WriteLine("Rozmiar początkowy: " + intList.size());
            Console.WriteLine("Element nr. 40: " + intList.element(40));
            Console.WriteLine("Element nr. 38: " + intList.element(38));
            Console.WriteLine("Rozmiar końcowy: " + intList.size());

            Console.WriteLine("-------------------------------------");

            //indeksowane od 1
            LazyPrimeList primeList = new LazyPrimeList();
            Console.WriteLine("Liczba pierwsza nr. 9: " + primeList.element(9));   
            Console.WriteLine("Rozmiar listy: " + primeList.size());
            Console.WriteLine("Liczba pierwsza nr. 1: " + primeList.element(1));
            Console.WriteLine("Liczba pierwsza nr. 19: " + primeList.element(19));
            Console.WriteLine("Rozmiar listy: " + primeList.size());
            
            Console.ReadKey();
        }
    }

    class LazyIntList 
    {
        private int list_size;
        private List<int> list;

        public LazyIntList()
        {
            list_size = -1;
            list = new List<int>();
        }
        //znajdywanie i-tego elementu listy
        public int element(int i)
        {
            if (i >= list_size)
            {
                for (int j = list_size + 1; j <= i; j++)
                {
                    list.Add(j);
                }
                list_size = i;
            }
            return list[i];
        }
        //rozmiar listy
        public int size()
        {
            return list.Count;
        }
    }   
    
    class LazyPrimeList : LazyIntList
    {
        private List<int> primes = new List<int>();

        //znajdywanie i-tej liczby pierwszej
        public new int element(int i)
        {
            while (primes.Count < i)
            {
                int n = 2;
                //biorę kolejną liczbę pierwszą, aby uniknąć duplikatów
                if (primes.Count > 0)
                {
                    n = primes.Last() + 1;
                }
                while (!isPrime(n))
                {
                    n++;
                }
                primes.Add(n);
            }
            return primes[i-1];
        }
        //rozmiar listy
        public new int size()
        {
            return primes.Count;
        }
        //sprawdzanie czy liczba jest pierwsza
        private bool isPrime(int n)
        {
            if (n < 2)
            {
                return false;
            }

            for (int i = 2; i <= Math.Sqrt(n); i++)
            {
                if (n % i == 0)
                {
                    return false;
                }
            }
            return true;
        }
    }
}