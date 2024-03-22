#include <iostream>
#include <algorithm>

using namespace std;
using ll = long long;

bool check_perfect(ll curr) {
    for (ll i = 0; i <= curr / 2; i++) {
        ll x = i * i;
        if (x == curr) {
            return true;
        } 
        else if (curr < x) {
            return false;
        }
    }
    return false;
} 

int main() {
    ll n;
    cin >> n;
    ll arr[n];
    for (ll i = 0; i < n; i++) {
        cin >> arr[i];
    }
    sort(arr, arr + n);

    for (ll i = n - 1; i >= 0; i--) {
        if (!check_perfect(arr[i])) {
            cout << arr[i] << endl;
            break;
        }
    }
    return 0;
}
