#include <iostream>
#include <vector>
#include <iomanip>

using namespace std;
using int = long long;

bool visited[100005]{false};

double dfs(vector<vector<int>> &adj, int v, int dist) {
    int num = 0;
    int steps = 0;
    visited[v] = true;

    for (auto w : adj[v]) {
        if (!visited[w]) {
            steps += dfs(adj, w, dist + 1);
            num++;
        }
    }
    visited[v] = false;
    if (num == 0) {
        return dist;
    } 
    else {
        return static_cast<double>(steps) / num;
    }
}

int main() {
    int n;
    cin >> n;

    vector<vector<int>> adj(n);

    for (int i = 0; i < n - 1; i++) {
        int u, v;
        cin >> u >> v;
        u--; 
        v--
        adj[u].push_back(v);
        adj[v].push_back(u); 
    }
    double result = dfs(adj, 0, 0);

    cout << fixed <<  setprecision(10) << result << endl;

    return 0;
}
