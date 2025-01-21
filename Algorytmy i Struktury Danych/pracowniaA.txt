#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
#include <stack>

using namespace std;

class Graph {
private:
    vector<pair<int, int>> edges;
    vector<int> time_in;
    vector<int> time_out;
    int time;

public:
    Graph(int vertices) : time(0) {
        edges.reserve(vertices);
        time_in.resize(vertices);
        time_out.resize(vertices);
    }

    void add_edge(int v, int w) {
        edges.emplace_back(v, w);
    }

    static bool compare_edges(const pair<int, int>& a, const pair<int, int>& b) {
        return a.first < b.first;
    }

    void sort_edges() {
        sort(edges.begin(), edges.end(), compare_edges);
    }

    pair<int, int> find(int parent) {
        auto start = lower_bound(edges.begin(), edges.end(), make_pair(parent, 0));
        auto end = lower_bound(edges.begin(), edges.end(), make_pair(parent + 1, 0));
        return make_pair(start - edges.begin(), end - edges.begin());
    }

    void visit(int start_v) {
        stack<int> stack;
        stack.push(start_v);

        while (!stack.empty()) {
            int current_v = stack.top();
            stack.pop();

            if (time_in[current_v] == 0) {
                time++;
                time_in[current_v] = time;
                stack.push(current_v); 
                auto children = find(current_v);
                for (int i = children.first; i < children.second; i++) {
                    int childVertex = edges[i].second;
                    if (time_in[childVertex] == 0) {
                        stack.push(childVertex);
                    }
                }
            } 
            else {
                if (time_out[current_v] == 0) {
                    time++;
                    time_out[current_v] = time;
                }
            }
        }
    }

    void is_laying(int v, int u) {
        if (time_in[v] <= time_in[u] && time_out[v] >= time_in[u]) {
            cout << "TAK" << endl;
        } else {
            cout << "NIE" << endl;
        }
    }
};

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);

    int n, questions;
    cin >> n >> questions;

    Graph graph(n+1);
    int tmp;
    for (int i = 2; i <= n; i++) {
        cin >> tmp;
        graph.add_edge(tmp, i);
    }

    graph.sort_edges();
    graph.visit(1);

    int a, b;
    while (questions--) {
        cin >> a >> b;
        graph.is_laying(a, b);
    }

    return 0;
}