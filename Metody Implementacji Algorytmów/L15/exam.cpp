#include <iostream>
using namespace std;
using ll = long long;

int main() {
    int ax, ay, bx, by, cx, cy;
    cin >> ax >> ay >> bx >> by >> cx >> cy;

    ll ba_x = bx - ax;
    ll ba_y = by - ay;
    ll cb_x = cx - bx;
    ll cb_y = cy - by;

    if (ba_x * cb_y == cb_x * ba_y) {
        cout << "No" << endl;
    } 
    else {
        if (ba_x * ba_x + ba_y * ba_y == cb_x * cb_x + cb_y * cb_y) {
            cout << "Yes" << endl;
        } 
        else {
            cout << "No" << endl;
        }
    }

    return 0;
}
