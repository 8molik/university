#include "AI.hpp"

array<array<int, 3>, 3> AI::priorities
{{
    {1, 2, 1},
    {2, 3, 2},
    {1, 2, 1}
}};

pair<int, int> AI::computerChoice(array<array<char, 3>, 3> board)
{
    
    vector<pair<int, int>> avaliableMoves;
    for (int i = 0; i < 3;  i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if (board[i][j] == ' ')
            {
                avaliableMoves.push_back(make_pair(i + 1, j + 1));
            }
        }
    }
    
    if (avaliableMoves.empty()) 
    {
        return std::make_pair(-1, -1);
    }

    int maxPriority = -1;
    vector<pair<int, int>> bestMoves;

    for (const auto& move : avaliableMoves)
    {
        int priority = priorities[move.first-1][move.second-1];
        if (priority > maxPriority)
        {
            maxPriority = priority;
            bestMoves.clear();
            bestMoves.push_back(make_pair(move.first, move.second));
        }
        else if (priority == maxPriority)
        {
            bestMoves.push_back(make_pair(move.first, move.second));
        }
    }
    
    srand(time(NULL));
    int randIndex = rand() % bestMoves.size();
    pair<int, int> computerMove = bestMoves[randIndex];
    bestMoves.clear();
    return computerMove;
}

