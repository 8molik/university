#include <iostream>

using namespace std;
using ll = long long;

int main(){
    ll n; 
    cin >> n;
    ll ans = n * (n - 1) * (n - 2) * (n - 3) * (n - 4) / 120;
    ans *= n * (n - 1) * (n - 2) * (n - 3) * (n - 4);
    cout << ans << endl;

    return 0;
}