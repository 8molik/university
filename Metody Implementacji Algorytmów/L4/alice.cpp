#include <iostream>

using namespace std;

int main() {
    int n, m, l;
    cin >> n >> m >> l;

    int arr[n];
    int cuts = 0;

    for (int i = 0; i < n; i++) {
        cin >> arr[i];
        if (i == 0){
            if (arr[i] > l){
                cuts++;
            }
        }
        else if(arr[i - 1] <= l && arr[i] > l){
            cuts++;
        }
    }

    while (m--) {
        int state;
        cin >> state;

        if (state != 0) {
            int i, grow;
            cin >> i >> grow;
            
            if(arr[--i] > l){
                continue;
            }
            arr[i] += grow;
            if (arr[i] > l){
                bool left = arr[i - 1] > l && i > 0;
                bool right = arr[i + 1] > l && i + 1 < n;
                if (left && right){
                    cuts--;
                }
                if (!left && !right){
                    cuts++;
                }
            }
        } 
        else {
            cout << cuts << endl;
        }
    }

    return 0;
}
