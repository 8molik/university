#include "Display.hpp"

void Display::display(array<array<char, 3>, 3> board)
{
    cout << endl << setw(4) << "a" << setw(4) << "b" << setw(4) << "c" << endl;
    for (int i = 0; i < 3; i++) 
    {
        string row = to_string(i + 1) + "  ";
        for (int j = 0; j < 3; j++) 
        {
            row += board[i][j];
            if (j != 2) 
            {
                row += " | ";
            }
        }
        cout << row << endl;
        if (i != 2) 
        {
            cout << "  -----------" << endl;
        }
    }
    cout << endl;
}