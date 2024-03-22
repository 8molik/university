#include <iostream>
#include <utility>
#include <cmath>
#include <iomanip>

using ll = long long;

using namespace std;

double get_distance(pair<ll, ll> a, pair<ll, ll> b){
    double x = pow(a.first - b.first, 2);
    double y = pow(a.second - b.second, 2);
    return sqrt(x + y);
}

int main(){
    ll n;
    cin >> n;
    pair<ll, ll> a;
    pair<ll, ll> b;
    pair<ll, ll> c;

    while(n--){
        cin >> a.first >> a.second;
        cin >> b.first >> b.second;
        cin >> c.first >> c.second;
        cout << fixed << setprecision(10);

        if (a.second == b.second && c.second < a.second){
            cout << get_distance(a, b) << endl;
        }
        else if (a.second == c.second && b.second < a.second){
            cout << get_distance(a, c) << endl;
        }
        else if (b.second == c.second && a.second < b.second){
            cout << get_distance(b, c) << endl;
        }
        else {
            cout << 0 << endl;
        }
    }
}