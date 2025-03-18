#include <iostream>
#include <limits>

using namespace std;
typedef long long ll;

ll MIN = numeric_limits<ll>::min();
ll MAX = numeric_limits<ll>::max();

class Node {
    public:
        ll val;
        Node* left;
        Node* right;
        int height;
        Node(ll value) : val(value), left(nullptr), right(nullptr), height(1) {}
};

class AVLTree{
    private:
        Node* root;

        int height(Node* N) { 
            if (N == nullptr) {
                return 0;
            }
            else {
                return N->height;
            }
        }

        void updateHeight(Node* N) {
            N->height = max(height(N->left), height(N->right)) + 1;
        }

        Node* rightRotation(Node* Q) {
            Node* P = Q->left;
            Node* B = P->right;

            P->right = Q;
            Q->left = B;

            updateHeight(Q);
            updateHeight(P);

            return P;
        }

        Node* leftRotation(Node* P) {
            Node* Q = P->right;
            Node* B = Q->left;
            
            Q->left = P;
            P->right = B;

            updateHeight(Q);
            updateHeight(P);

            return Q;
        }
        
        int getHeightDiff(Node* N) {
            if (N == nullptr) {
                return 0;
            }
            else {
                return height(N->left) - height(N->right);
            }
        }

        Node* minValue(Node* N) {
            Node* current = N;
            while (current->left != nullptr) { 
                current = current->left;
            }
            return current;
        }

        Node* balance(Node* N) {
            if (N == nullptr)
                return N;

            updateHeight(N);

            int height_diff = getHeightDiff(N);

            if (height_diff > 1) {
                if (getHeightDiff(N->left) >= 0)
                    return rightRotation(N);
                else {
                    N->left = leftRotation(N->left);
                    return rightRotation(N);
                }
            } 
            else if (height_diff < -1) {
                if (getHeightDiff(N->right) <= 0)
                    return leftRotation(N);
                else {
                    N->right = rightRotation(N->right);
                    return leftRotation(N);
                }
            }
            return N;
        }

        Node* insert(Node* N, ll value) {
            if (N == nullptr) {
                return new Node(value);
            }

            if (value < N->val) {
                N->left = insert(N->left, value);
            }
            else if (value > N->val) {
                N->right = insert(N->right, value);
            }
            else {
                return N;
            }

            return balance(N);
        }

        Node* deleteNode(Node* N, ll value) {
            if (N == nullptr) {
                return N;
            }

            if (value < N->val) {
                N->left = deleteNode(N->left, value);
            }
            else if (value > N->val) {
                N->right = deleteNode(N->right, value);
            }

            else {
                if (N->left == nullptr && N->right == nullptr) {
                    delete N;
                    return nullptr;
                }
                if (N->left == nullptr) {
                    Node* temp = N->right;
                    delete N;
                    return temp;
                }
                else if (N->right == nullptr) {
                    Node* temp = N->left;
                    delete N;
                    return temp;
                }
                else {
                    Node* temp = minValue(N->right);
                    N->val = temp->val;
                    N->right = deleteNode(N->right, temp->val);
                }
            }

            return balance(N);
        }

        Node* upper(Node* N, ll value) {
            Node* upperNode = nullptr;

            while (N != nullptr) {
                if (N->val >= value) {
                    upperNode = N;
                    N = N->left;
                } 
                else {
                    N = N->right;
                }
            }
            return upperNode;
        }

        Node* lower(Node* N, ll value) {
            Node* lowerNode = nullptr;

            while (N != nullptr) {
                if (N->val <= value) {
                    lowerNode = N;
                    N = N->right;
                } 
                else {
                    N = N->left;
                }
            }
            return lowerNode;
        }
        void destroyTree(Node* N) {
            if (N) {
                destroyTree(N->left);
                destroyTree(N->right);
                delete N;
            }
        }
    public:
        AVLTree() : root(nullptr) {}

        ~AVLTree() {
            destroyTree(root);
        }

        void Insert(ll value) {
            root = insert(root, value);
        }

        void Delete(ll value) {
            root = deleteNode(root, value);
        }

        ll Upper(ll x) {
            Node* result = upper(root, x);
            if (result) {
                return result->val;
            }
            else {
                return MAX;
            }
        }

        ll Lower(ll x) {
            Node* result = lower(root, x);
            if (result) {
                return result->val;
            }
            else {
                return MIN;
            }
        }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    AVLTree root;
    int n;
    cin >> n;

    while(n--) {
        char op;
        ll value;

        cin >> op >> value;

        if (op == 'I') {
            root.Insert(value);
        }
        else if (op == 'D') {
            if (root.Upper(value) == value) {
                root.Delete(value);
                cout << "OK\n";
            } 
            else {
                cout << "BRAK\n";
            }
        }
        else if (op == 'U') {
            ll result = root.Upper(value);
            if (result != MAX) {
                cout << result << "\n";
            } 
            else {
                cout << "BRAK\n";
            }
        } 
        else if (op == 'L') {
            ll result = root.Lower(value);
            if (result != MIN) {
                cout << result << "\n";
            } 
            else {
                cout << "BRAK\n";
            }
        } 
    }
    return 0;
}