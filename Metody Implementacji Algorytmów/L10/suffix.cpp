#include <iostream>
#include <algorithm>

using namespace std;

bool array(string a, string b){
    sort(a.begin(), a.end());
    sort(b.begin(), b.end());
    return a == b;
}

bool automaton(string a, string b){
    string c = "";
    int j = 0;
    for (int i = 0; i < a.length(); i++){
       

        if (a[i] == b[j]){
            c += a[i];
            j++;
        }
    }
    return c == b;
}

bool both(string a, string b){
    for (int i = 0; i < b.length(); i++){
        int j = a.find(b[i]);
        if (j == -1){
            return false;
        }
        a[j] = '1';
    }
    return true;
}

int main(){
    string a;
    string b;
    cin >> a >> b;
    
    if (array(a, b)){
        cout << "array" << endl;
    }

    else if (automaton(a, b)){
        cout << "automaton" << endl;
    }

    else if (both(a, b)){
        cout << "both" << endl;
    } 

    else{
        cout << "need tree" << endl;
    }
    return 0; 
}
