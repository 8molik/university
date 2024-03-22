#pragma once
#include "GameState.hpp"
#include <vector>
#include <cstdlib>
#include <ctime>

namespace AI
{
    extern array<array<int, 3>, 3> priorities;    
    pair<int, int> computerChoice(array<array<char, 3>, 3> board);
}
