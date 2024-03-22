#include <iostream>

using namespace std;

void solve(){
    int n;
    cin >> n;
    int q[n];
    for (int i = 0; i < n; i++){
        cin >> q[i];
    }

    for (int i = 0; i < n; i++){
        int days = 1;
        int next = q[q[i] - 1];

        while (next != q[i]){
            next = q[next - 1];
            days++;
        }
        cout << days << " ";
    }
    cout << endl;
}

int main(){
    int q;
    cin >> q;
    while(q--){
        solve();
    }
    return 0;
}