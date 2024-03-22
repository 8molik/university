#include <iostream>
#include <algorithm>

#define ll long long

using namespace std;

int main(){
    ll n, m;
    cin >> n >> m;
    ll a[n], b[m];

    for (int i = 0; i < n; i++){
        cin >> a[i];
    }

    for (int i = 0; i < m; i++){
        cin >> b[i];
    }

    sort(a, a + n); 
    
    for (int j = 0; j < m; j++){
        cout << upper_bound(a, a + n, b[j]) - a << " ";
    }
}
