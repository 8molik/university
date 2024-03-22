#include <iostream>

using namespace std;

int main(){
    int n;
    cin >> n;

    int q[n];
    for (int i = 0; i < n; i++){
        cin >> q[i];
    }

    for (int i = 0; i < n; i++){
        int counter = 0;

        int prev = q[i];
        int next = q[prev - 1];
        
        for (int j = 0; j < 3; j++){
            if (prev != next){
                counter++;
            }
            prev = next;
            next = q[prev - 1];
            if (counter == 3 && q[i] == prev){
                cout << "YES";
                return 0;
            }
        }        
    }
    cout << "NO";
    return 0;
}