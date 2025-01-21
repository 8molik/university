#include <iostream>
#include <vector>
#include <climits>

using namespace std;

vector<int> find_used(int waga, int n, vector<int>& wagi, vector<int>& nominaly, vector<int>& memo){
    vector<int> uzyte_monety(n, 0);
    for (int i = n - 1; i >= 0 && waga > 0; i--) {
        while (waga >= wagi[i] && memo[waga] == memo[waga - wagi[i]] + nominaly[i]) {
            uzyte_monety[i]++;
            waga -= wagi[i];
        }
    }
    return uzyte_monety;
}

pair<int, vector<int>> find_max(vector<int>& nominaly, vector<int>& wagi, int waga_monet, int n){
    vector<int> memo(waga_monet + 1, INT_MIN);
    memo[0] = 0;
    
    for(int i = 0; i <= waga_monet; i++){
        for(int j = 0; j < n; j++){
            if (wagi[j] <= i){ 
                memo[i] = max(memo[i], memo[i - wagi[j]] + nominaly[j]);
            }
        }
    }
    vector<int> uzyte_monety = find_used(waga_monet, n, wagi, nominaly, memo);

    return {memo[waga_monet], uzyte_monety};
}

pair<int, vector<int>> find_min(vector<int>& nominaly, vector<int>& wagi, int waga_monet, int n){
    vector<int> memo(waga_monet + 1, INT_MAX); 
    memo[0] = 0; 

    for(int i = 1; i <= waga_monet; i++){
        for(int j = 0; j < n; j++){
            if (wagi[j] <= i){ 
                if (memo[i - wagi[j]] != INT_MAX) {
                    memo[i] = min(memo[i], memo[i - wagi[j]] + nominaly[j]); 
                }
            }
        }
    }
    vector<int> uzyte_monety = find_used(waga_monet, n, wagi, nominaly, memo);

    return {memo[waga_monet], uzyte_monety};
}

int  main() {
    int waga_monet;
    int n;
    cin >> waga_monet;
    cin >> n;

    vector<int> wagi(n);
    vector<int> nominaly(n);

    for (int i = 0; i < n; i++) {
        cin >> nominaly[i] >> wagi[i];
    }
    
    pair<int, vector<int>> r2 = find_min(nominaly, wagi, waga_monet, n);

    if (r2.first != INT_MAX) {
        cout << "TAK" << endl;
        pair<int, vector<int>> r1 = find_max(nominaly, wagi, waga_monet, n);
        
        cout << r2.first << endl;
        for (int k = 0; k < n; k++) {
            cout << r2.second[k] << " ";
        }
        cout << endl;

        cout << r1.first << endl;
        for (int k = 0; k < n; k++) {
            cout << r1.second[k] << " ";
        }
        cout << endl;
    } 
    else {
        cout << "NIE";
    }

    return 0;
}