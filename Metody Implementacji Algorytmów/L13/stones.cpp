#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;
using ll = long long;

ll question(int l, int r, const vector<ll>& arr) {
    ll sum = 0;
    for (int i = l - 1; i < r; i++) {
        sum += arr[i];
    }
    return sum;
}

int main() {
    int n;
    cin >> n;
    vector<ll> arr(n);

    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    vector<ll> arr2(arr);
    sort(arr2.begin(), arr2.end());

    int m;
    cin >> m;

    while (m--) {
        int q, l, r;
        cin >> q >> l >> r;

        if (q == 1) {
            cout << question(l, r, arr) << endl;
        } else if (q == 2) {
            cout << question(l, r, arr2) << endl;
        }
    }
    return 0;
}
