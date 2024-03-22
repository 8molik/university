using System;

namespace Zadanie1
{
    class Program
    {
        static void Main(string[] args)
        {
            //Przykładowe wywołania
            Console.WriteLine("IntStream dla 5 liczb:");
            IntStream number = new IntStream();
            for (int i = 0; i < 5; i++)
            {
                number.next();
                number.print();  
            }
            Console.WriteLine("Status eos: " + number.eos());
            Console.WriteLine("------------------------");
            Console.WriteLine("PrimeStream dla 5 liczb:");

            PrimeStream prime_number = new PrimeStream();
            for (int i = 0; i < 5; i ++)
            {
                prime_number.next();
                prime_number.print();
            }
            Console.WriteLine("Status eos: " + prime_number.eos());
            Console.WriteLine("------------------------");
            Console.WriteLine("RandomStream dla 5 liczb:");

            RandomStream random_number = new RandomStream();
            for (int i = 0; i < 5; i++)
            {
                random_number.next();
                random_number.print();
            }
            Console.WriteLine("Status eos: " + random_number.eos());
            Console.WriteLine("------------------------");
            Console.WriteLine("RandomWordStream dla 5 liczb pierwszych:");
            
            RandomWordStream random_string = new RandomWordStream();
            for (int i = 0; i < 5; i++){
                
                Console.WriteLine(random_string.next());
            }
            Console.ReadKey();
        }
    }

    class IntStream
    {
        public int number = -1; // Domyślna wartość, po to aby metoda next() wypisywała liczby od 0

        public int next()
        {
            return number++;
        }

        public void print()
        {
            Console.WriteLine(number);
        }

        public bool eos()
        {
            return !(number <= int.MaxValue && number >= 0); //wartość eos jest fałszywa dopóki number jest w zakresie int
        }

        public void reset()
        {
            number = 0;
        }
    }

    class PrimeStream : IntStream
    {
        //zwraca liczbę tylko, gdy jest pierwsza
        public new int next()
        {
            while (true)
            {
                number += 1;
                if (isPrime(number))
                {
                    return number;
                }
            }
        }
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

    class RandomStream : IntStream
    {
        private Random rand = new Random();
        public new int next()
        {
            number = rand.Next();
            return number;
        }
        public new bool eos()
        {
            return false;
        }

        public new void print()
        {
            Console.WriteLine(number);
        }
    }

    public class RandomWordStream 
    {
        private PrimeStream primes = new PrimeStream();
        private RandomStream random = new RandomStream();

        public string next() 
        {
            int length = primes.next();
            string word = "";

            for (int i = 0; i < length; i++) 
            {
                char c = (char)(random.next() % 26 + 97); // losowy znak z zakresu a-z
                word += c;
            }
            return word;
        }
    }
}
