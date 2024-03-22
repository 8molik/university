#include <iostream>

using namespace std;

int main(){
    string s;
    cin >> s;
    long long len = s.length();

    long long ans = 0;

    if ((s[0] - '0') % 4 == 0){
        ans++;
        if (len == 1){   
            cout << ans;
            return 0;
        }
    }    

    for (int i = 1; i < len; i++){
        if ((s[i] - '0') % 4 == 0){
            ans++;
        }
        
        if (((s[i - 1] - '0') * 10 + s[i] - '0') % 4 == 0){
            ans += i;
        }
    }
    cout << ans;
    return 0;
}