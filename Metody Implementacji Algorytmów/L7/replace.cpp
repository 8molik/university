#include <iostream>
#include <cmath>
using namespace std;

int main(){
    long long n;
    cin >> n;

    string s;
    string t;
    long long result;

    while(n--) {
        cin >> s;
        cin >> t;

        if (t.size() == 1 && t[0] == 'a'){
            result = 1;
        }
        else if (t.find('a') != string::npos){
            result = -1;
        }
        else{
            result = static_cast<long long>(pow(2, s.size()));
        }
        cout << result << endl;     
    }

    return 0;
}