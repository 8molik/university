#include <iostream>
#include <vector>
#include <string>

using namespace std;

int check(string num, int a, int b) {
    int len = num.length();

    int x[len + 1] = {-1};
    int y[len + 1] = {-1};

    x[0] = (num[0] - '0') % a;
    y[len - 1] = (num[len - 1] - '0') % b;

    for (int i = 1; i < len; i++) {
        x[i] = (10 * x[i - 1] + (num[i] - '0')) % a;
    }

    int t = 1;
    for (int i = len - 1; i >= 0; i--) {
        y[i] = (t * (num[i] - '0') + y[i + 1]) % b;
        t = (t * 10) % b;
    }
    for (int i = 0; i < len - 1; i++) {
        if (x[i] == 0 && y[i + 1] == 0 && num[i + 1] != '0') {
            return i;
        }
    }
    return -1;
}

int main() {
    string num;
    cin >> num;
    int a, b;
    cin >> a >> b;

    int i = check(num, a, b);
    if (i != -1) {
        cout << "YES" << endl;
        cout << num.substr(0, i + 1) << endl;
        cout << num.substr(i + 1) << endl;
    } 
    else {
        cout << "NO" << endl;
    }

    return 0;
}
