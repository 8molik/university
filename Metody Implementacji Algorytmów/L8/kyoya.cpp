#include <iostream>

using namespace std;

int main(){

    long long modulo =  1000000007;
    int t = 1005;
    int c[t][t];

    for(int i = 0; i < t; i++){
        for(int j = 0; j < t; j++){
            if (j == 0){
                c[i][j] = 1;
            }
            else{
                c[i][j] = (c[i - 1][j] + c[i - 1][j - 1]) % modulo;
            }
        }
    }

    int n;
	cin >> n;

	long long total = 0;
	long long answer = 1;
    long long colors;

	while(n--)
	{
		cin >> colors;
		answer *= c[total + colors - 1][colors - 1];
        answer %= modulo;
		total += colors;
	}
	cout << answer;


    return 0;
}