#include <iostream>

using namespace std;

// xa + yb + zc = n
// zc = n - xa - xb
// z = (n - xa - xb) / c

int main(){
    int n, a, b, c;
    cin >> n >> a >> b >> c;
    cout << n << a << b << c;

    int ans = 0;

    for (int i = 0; i * a <= n; i++){
        for (int j = 0;  i * a + j * b <= n; j++){
            int k = n - j * b - i * a;
            if (k % c == 0){
                ans = max(ans, i + j + k/c;);
            }
        }
    }
    cout << ans << endl;
    return 0;
}