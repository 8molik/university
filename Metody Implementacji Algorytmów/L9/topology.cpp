#include <iostream>
#include <vector>

using namespace std;

void bus(){
    
}

int main(){
    int n, m; 
    cin >> n >> m;
	
	vector<int> degrees(n+1);
	
	int a, b;
	
	for (int i = 0; i < m; i++) {
		cin >> a >> b;
		degrees[a]++;
		degrees[b]++;
	}
	
    if (m == n - 1) {
        int sum = 0;
        for (int j = 1; j < n + 1; j++){
            sum += degrees[j];
        }

        int cnt = 0;
        for (int i = 1; i < n + 1; i++){
            if (degrees[i] == 1){
                cnt++;
            }
            if (degrees[i] == m && (sum - m) % (n - 1) == 0){
                cout << "star topology";
                return 0;
            }
        }

        if (cnt == 2){
            cout << "bus topology";
            return 0;
        }

    }
    else{
        for (int i = 1; i < n + 1; i++){
            if (degrees[i] != 2){
                break;
            }
            if (degrees[i] == 2 && i == n){
                cout << "ring topology";
                return 0;
            }
        }
    }
    cout << "unknown topology";
    return 0;
}