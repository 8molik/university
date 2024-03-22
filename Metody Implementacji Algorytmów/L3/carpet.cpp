#include <iostream>
#include <vector>

using namespace std;

void solve(){
    int rows;
    int cols;
    cin >> rows >> cols;
    
    string vika = "vika";

    vector<string> carpet(rows);
    for (int j = 0; j < rows; j++) {
        cin >> carpet[j];
    }

    int counter = 0;

    for(int k = 0; k < cols; k++){
        for(int l = 0; l < rows; l++){
            if (carpet[l][k] == vika[counter]){
                counter++;
                break;
            }
        }

        if (counter == 4){
            cout << "YES" << endl;
            break;
        }
    }
    if (counter != 4){
        cout << "NO" << endl;
    }
}

int main(){
    int tests;
    cin >> tests;    
    for (int i = 0; i < tests; i++){
        solve();
    }
    return 0;
}