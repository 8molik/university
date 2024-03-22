#include <iostream>
#include <algorithm>

using namespace std;

int n;

int get_price(int k, int arr[]) {
    int costs[n];
    int sum = 0;
    for (int i = 0; i < n; i++) {
        costs[i] = arr[i] + (i + 1) * k;
    }
    sort(arr.begin(), arr.end());
    for (int i = 0; i < k; i++) {
        sum += costs[i];
    }

    return sum;
}

int main() {
    int budget;
    cin >> n >> budget;

    int arr[n];

    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    int top = n;
    int bot = 0;
    int mid, k;
    int ans, cost;

    while (top >= bot) {
        mid = (top + bot) / 2;
        k = get_price(mid, arr);
        if (k == budget) {
            cout << mid << " " << k << endl;
            return 0; // exit the program
        } else if (k < budget) {
            bot = mid + 1;
            ans = mid;
            cost = k;
        } else {
            top = mid - 1;
        }
    }
    cout << ans << " " << cost << endl;

    return 0;
}
