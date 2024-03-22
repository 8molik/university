#include <iostream>
#include <cmath>

using namespace std;

int main(){
    int n;
    cin >> n;
    int a, b, c;
    while(n--){
        cin >> a >> b >> c;
        if ((a + ceil(c / 2.0)) > (b + floor(c / 2.0))){
            cout << "First" << endl;
        }
        else{
            cout << "Second" << endl;
        }
    }
    return 0;
}