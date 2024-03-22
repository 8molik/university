#include <iostream>

using namespace std;

class tab_bit
{
    typedef uint64_t slowo; // komorka w tablicy
    static const int rozmiarSlowa; // rozmiar slowa w bitach
    friend istream & operator >> (istream &we, tab_bit &tb);
    friend ostream & operator << (ostream &wy, const tab_bit &tb);
    class ref; // klasa pomocnicza do adresowania bitów
    protected:
        int dl; // liczba bitów
        slowo *tab; // tablica bitów
        public:
        explicit tab_bit (int rozm); // wyzerowana tablica bitow [0...rozm]
        explicit tab_bit (slowo tb); // tablica bitów [0...rozmiarSlowa]
        // zainicjalizowana wzorcem
        tab_bit (const tab_bit &tb); // konstruktor kopiujący
        tab_bit (tab_bit &&tb); // konstruktor przenoszący
        tab_bit & operator = (const tab_bit &tb); // przypisanie kopiujące
        tab_bit & operator = (tab_bit &&tb); // przypisanie przenoszące
        ~tab_bit (); // destruktor
    private:
        bool czytaj (int i) const; // metoda pomocnicza do odczytu bitu
        bool pisz (int i, bool b); // metoda pomocnicza do zapisu bitu
    public:
        bool operator[] (int i) const; // indeksowanie dla stałych tablic bitowych
        ref operator[] (int i); // indeksowanie dla zwykłych tablic bitowych
        inline int rozmiar () const; // rozmiar tablicy w bitach
    public:
    // operatory bitowe: | i |=, & i &=, ^ i ^= oraz !
    public:
    // zaprzyjaźnione operatory strumieniowe: << i >>

};



tab_bit::tab_bit(int rozm)
{
    tab = new slowo[rozm/rozmiarSlowa+1];
    for (int i = 0; i < rozm/rozmiarSlowa+1; i++)
    {
        tab[i] = 0;
    }
    dl = rozm;
}

tab_bit::tab_bit(slowo tb)
{
    tab = new slowo[rozmiarSlowa];
    for (int i = 0; i < rozmiarSlowa; i++)
    {
        tab[i] = 0;
    }
    dl = rozmiarSlowa;
}

