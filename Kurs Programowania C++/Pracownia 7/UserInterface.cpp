#include "UserInterface.hpp"

using namespace AI;
using namespace GameState;
using namespace Display;
using namespace std;

void UI::StartGame()
{
    cout << "Welcome to Tic Tac Toe!" << endl;
        
    Board b;
    char pside = ' ';

    while (pside != 'x' && pside != 'o')
    {    
        cout << "Choose your side (x, o): ";
        cin >> pside;
        if (pside != 'x' && pside != 'o')
        {
            cout << "Choose correct side!" << endl;
        }
    }
    
    char cside = (pside == 'x') ? 'o' : 'x';
    
    cout << "To make a move, enter a letter (a, b, c) followed by a number (1, 2, 3)." << endl;

    while (true)
    {
        char x;
        char y;

        int row;
        char col;

        display(b.board);

        while (true) 
        {
            cout << "Your Move: ";
            cin >> x >> y;

            if (isdigit(x))
            {
                row = x - '0';
                col = y;
            }
            else
            {
                row = y - '0';
                col = x;
            }

            col = toupper(col);

            if (row < 1 || row > 3 || col != 'A' && col != 'B' && col != 'C') 
            {
                cout << "Wrong arguments" << endl;
                cin.ignore();
                cin.clear();
            } 
            else if (!b.isFree(row, (col == 'A') ? 1 : (col == 'B') ? 2 : 3)) 
            {
                cout << "Square is already filled" << endl;
                cin.ignore();
                cin.clear();
            }
            else 
            {
                break;
            }
        }
        
        b.makeMove(pside, row, (col == 'A') ? 1 : (col == 'B') ? 2 : 3);

        if (b.checkWin(pside))
        {
            cout << "You win!";
            display(b.board);
            break;
        }
        pair<int, int> result = computerChoice(b.board);

        b.makeMove(cside, result.first, result.second);

        display(b.board);
        
        if (b.checkWin(cside))
        {
            cout << "You lose!";
            break;
        }
        else if (b.isFull())
        {
            cout << "Draw!";
            break;
        }
    }
}
