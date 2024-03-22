#include <iostream>

using namespace std;

int main(){
    int n;
    cin >> n;
    string arr[n];
    for (int i = 0; i < n; i++){
        cin >> arr[i];
    }

    for (int i = 0; i < n; i++){
        int sum = 0;
        int zeros = 0;
        int even = 0;
        for(int j = 0; j < arr[i].length(); j++){
            int t = arr[i][j];
            sum += t;

            if (t == '0'){
                zeros++;
                even++;
            }
            else if (t % 2 == 0){
                    even++;
            }        
        }
        if ((sum % 3 == 0 && zeros > 0) && even > 1){
            cout << "red" << endl;
        }
        else{
            cout << "cyan" << endl;
        }
    }


    return 0;
}