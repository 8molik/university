#include <iostream>
#include <algorithm>

using namespace std;

int main(){
    int n;
    cin >> n;
    

    while(n--){
        int l;
        cin >> l;
        string s;
        cin >> s;
        
        string ans = "";
        ans += s[0];

        if (s[0] == s[1] || s[0] < s[1]){
            cout << ans << ans << endl;
            
        }
        else{
            for (int i = 1; i < l; i++){
                if (s[i - 1] >= s[i]){
                    ans += s[i];
                }
                else{
                    break;
                }
            }
            cout << ans;
            reverse(ans.begin(), ans.end());
            cout << ans << endl;
        }
    }
    return 0;
}