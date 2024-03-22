#include "GameState.hpp"

GameState::Board::Board()
{
    this->board = board;
}

bool GameState::Board::isFull()
{
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if (board[i][j] == ' ')
            {
                return false;
            }
        }
    }
    return true;
}

void GameState::Board::makeMove(char symbol, int x, int y)
{
    try
    {
        if (x > 0 && x < 4 && y > 0 && y < 4)
        {
            if (board[x - 1][y - 1] != ' ')
            {
                throw invalid_argument("makeMove: Position is already taken");
            }
            else
            {
                board[x - 1][y - 1] = symbol;
            }
        }
        else
        {
                
            throw invalid_argument("makeMove: Wrong argument");
        }
    }
    catch(const exception& e)
    {
        cerr << e.what() << '\n';
    }
}

bool GameState::Board::checkWin(char symbol)
{
    for (int i = 0; i < 3; i++)
    {
        if (board[i][0] == symbol && board[i][1] == symbol && board[i][2] == symbol) 
        {
            return true;
        }
        else if (board[0][i] == symbol && board[1][i] == symbol && board[2][i] == symbol)
        {
            return true;
        }
    }

    if (board[0][0] == symbol && board[1][1] == symbol && board[2][2] == symbol)
    {
        return true;
    }

    if (board[0][2] == symbol && board[1][1] == symbol && board[2][0] == symbol) 
    {
        return true;
    }
    return false;
}

bool GameState::Board::isFree(int x, int y)
{
    return !(board[x-1][y-1] != ' ');
}