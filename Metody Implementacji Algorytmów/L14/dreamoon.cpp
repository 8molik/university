#include <iostream>
#include <cmath>
using namespace std;

int pos1, pos2, unknown, combinationCount;

void comb(int n, int m)
{
    if(m == 0)
    {
        if(n == pos1)
            combinationCount++;
        return;
    }

    comb(n + 1, m - 1);
    comb(n - 1, m - 1);
}

int main()
{
    string s1, s2;

    cin >> s1 >> s2;

    pos1 = 0;

    for(int i = 0; i < s1.length(); i++)
    {
        if(s1[i] == '+') {
            pos1++;
        }
        else {
            pos1--;
        }
    }

    pos2 = 0;
    unknown = 0;

    for(int i = 0; i < s2.length(); i++)
    {
        if(s2[i] == '+') {
            pos2++;
        }
        else if(s2[i] == '-') { 
            pos2--;
        }
        else {
            unknown++;
        }
    }

    combinationCount = 0;

    comb(pos2, unknown);

    float probability = (1.0 / pow(2, unknown)) * combinationCount;
    cout.precision(15);

    cout << fixed << probability;
    return 0;
}
