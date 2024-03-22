#include <iostream>

using namespace std;

bool tab[100001];

int main(){
    int n;
    cin >> n;
    int current = n;

    while (n--){
        int num;
        cin >> num;
        tab[num] = 1;
        
        if (num == current){
            for (int i = current; i > 0; i--){
                if (tab[i]){
                    cout << i << " ";
                    tab[i] = 0;
                    current = i - 1;
                }
                else {
                    break;
                }
            }
        }
        cout << endl;
    }
    return 0;
}