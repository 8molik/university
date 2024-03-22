#include <bits/stdc++.h>

using namespace std;
   
int main(){
    long long n, x, y;
    cin >> n >> x >> y;
    string t;
    cin >> t;
    
    int zeros_sub = 0;

    for (int i = 0; i < t.length(); i++){
        if (i == 0 && t[i] == '0'){
            zeros_sub++;
        }
        else if (t[i - 1] == '1' && t[i] == '0'){
            zeros_sub++;
        }
    }

    if (!zeros_sub){
        cout << 0;
    }
    else if (x <= y){
        cout << (zeros_sub - 1) * x + y << endl;
    }
    else{
        cout << zeros_sub * y << endl;
    }
}