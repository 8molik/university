#include <iostream>
#include <vector>
using namespace std;

const int MAX = 200000;
vector<int> parent(MAX);

int findParent(int u) {
    if (parent[u] == u) {
        return u;
    }
    int f = findParent(parent[u]);
    parent[u] = f;
    return f;
}

int main() {
    int res = 0;
    int root = -1;
    int n;
    cin >> n;
    vector<int> pa(n + 1, 0);

    for (int i = 1; i <= n; ++i) {
        parent[i] = i;
    }

    for (int i = 1; i <= n; ++i) {
        cin >> pa[i];

        if (pa[i] == i) {
            root = i;
        }
    }

    for (int i = 1; i <= n; ++i) {
        if (i == root) {
            continue;
        }

        int fc = findParent(i);
        int fp = findParent(pa[i]);

        if (fc != fp) {
            parent[fc] = fp;
        } else {
            res += 1;
            if (root == -1) {
                root = i;
            }
            parent[fc] = findParent(root);
            pa[i] = parent[fc];
        }
    }

    cout << res << endl;
    for (int i = 1; i <= n; ++i) {
        cout << pa[i] << " ";
    }
    cout << endl;

    return 0;
}
