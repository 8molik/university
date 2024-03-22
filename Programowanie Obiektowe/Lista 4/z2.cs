//Błażej Molik
//Zadanie 2
//.NET 7.0
//Aby uruchomić program należy otworzyć terminal w folderze i wpisać dotnet run

using System;
using System.Collections;
using System.Collections.Generic;

class Program
{
    static void Main(string[] args)
    {
        FibonacciWords sf = new FibonacciWords(6);
        foreach (string s in sf)
        {
            Console.WriteLine(s);
        }
    }
}

class FibonacciWords : IEnumerable<string>, IEnumerator<string>
{
    private int wordsNumber;
    private int current = 0;
    private List<string> words = new List<string> ();

    public FibonacciWords(int wordsNumber)
    {
        this.wordsNumber = wordsNumber;
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }

    public IEnumerator<string> GetEnumerator()
    {
        return this;
    }

    public bool MoveNext()
    {
        if (current == 0)
        {
            words.Add("b");
            current++;
            return true;
        }
        else if (current == 1)
        {
            words.Add("a");
            current++;
            return true;
        }
    
        else
        {
            if (current < wordsNumber)
            {
                string newWord = words[current-1] + words[current-2];
                words.Add(newWord);
                current++;
                return true;
            }
            else
            {
                return false;
            }
        }
    }
    public string Current 
    {
        get { return words[current-1]; }
    }
    public void Reset()
    {
        current = 0;
    }
    object IEnumerator.Current
    {
        get { return Current; }
    }

    public void Dispose(){}
}

