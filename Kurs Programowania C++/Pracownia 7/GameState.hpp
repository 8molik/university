#pragma once
#include <iostream>
#include <array>

using namespace std;

namespace GameState
{
    class Board
    {
        public:
            array<array<char, 3>, 3> board 
                {{
                    {' ', ' ', ' '},
                    {' ', ' ', ' '},
                    {' ', ' ', ' '}
                }};
            Board();
            bool isFull();    
            void makeMove(char symbol, int x, int y);
            bool checkWin(char symbol);
            bool isFree(int x, int y);
    };
}