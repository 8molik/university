#include <iostream>
#include <string>
    
using namespace std;
    
int count(string places, int n, int a, int b) {
    int max_students = 0;
    
    for (int i = 0; i < n; i++) {
        if (places[i] == '*'){
            continue;
        }
        if(a == 0 && b == 0)
        {
            break;
        }
        if (i == 0){
            a--;
            max_students++;
            places[i] = 'a';
        }
        else{
            if (places[i - 1] == '*'){
                if (a > b){
                    a--;
                    max_students++;
                    places[i] = 'a';
                }
                else{
                    b--;
                    max_students++;
                    places[i] = 'b';
                }
            }
            else if (places[i - 1] == 'a'){
                if (b > 0){
                    b--;
                    max_students++;
                    places[i] = 'b';
                }
                else{
                    continue;
                }
            }
            else{
                if (a > 0){ 
                    a--;
                    max_students++;
                    places[i] = 'a';
                }
                else{
                    continue;
                }
            }
        }
    }
    return max_students;
}
    
int main() {
    int n, a, b;
    cin >> n >> a >> b;
    string places;
    cin >> places;
    
    if (a > b){
        cout << count(places, n, a, b) << endl;
    }
    else{
        cout << count(places, n, b, a) << endl;
    }
    
    return 0;
}