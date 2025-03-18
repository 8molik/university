#include <iostream>
#include <algorithm>
#include <vector>
#include <cmath>
#include <tuple> 

using namespace std;

struct Point {
    int x;
    int y;
};

const int MAX_CRD = 10000005; 

double findDistance(Point& a, Point& b){
    return sqrt(pow(a.x - b.x, 2) + (pow(a.y - b.y, 2)));
}

tuple<double, Point, Point, Point> closestBruteForce(vector<Point>& points){
    double min_dist = MAX_CRD;
    int pointsLength = points.size();
    Point p1, p2, p3;

    for (int i = 0; i < pointsLength; i++){
        for (int j = i + 1; j < pointsLength; j++){
            for (int k = j + 1; k < pointsLength; k++){
                double dist = findDistance(points[i], points[j]) + 
                              findDistance(points[i], points[k]) +
                              findDistance(points[j], points[k]);
                if (dist < min_dist){
                    min_dist = dist;
                    p1 = points[i];
                    p2 = points[j];
                    p3 = points[k];
                }
            }
        }
    }
    return make_tuple(min_dist, p1, p2, p3);
}

vector<Point> sortByX(vector<Point>& points){
    vector<Point> xSorted = points;
    sort(xSorted.begin(), xSorted.end(), [](Point a, Point b) { return a.x < b.x; });
    return xSorted;
}

vector<Point> sortByY(vector<Point>& points){
    vector<Point> ySorted = points;
    sort(ySorted.begin(), ySorted.end(), [](Point a, Point b) { return a.y < b.y; });
    return ySorted;
}

tuple<double, Point, Point, Point> findSmallestTriangle(vector<Point>& xSorted, vector<Point>& ySorted){
    int n = xSorted.size();

    if (n < 4) {
        return closestBruteForce(xSorted);
    }
    else {
        Point mid = xSorted[n / 2];
        vector<Point> xSorted_left(xSorted.begin(), xSorted.begin() + n / 2);
        vector<Point> xSorted_right(xSorted.begin() + n / 2, xSorted.end());
        vector<Point> ySorted_left;
        vector<Point> ySorted_right;

        for (const auto& point : ySorted){
            if (point.x <= mid.x){
                ySorted_left.push_back(point);
            }
            else {
                ySorted_right.push_back(point);
            }
        }
        auto [delta_left, p1_left, p2_left, p3_left] = findSmallestTriangle(xSorted_left, ySorted_left);
        auto [delta_right, p1_right, p2_right, p3_right] = findSmallestTriangle(xSorted_right, ySorted_right);

        tuple<double, Point, Point, Point> result;

        if (delta_left < delta_right){
            result = make_tuple(delta_left, p1_left, p2_left, p3_left);
        }
        else{
            result = make_tuple(delta_right, p1_right, p2_right, p3_right);
        }
        
        auto [delta, p1, p2, p3] = result;

        vector<Point> between;
        for (const auto& point : ySorted){
            if (mid.x - delta < point.x && point.x < mid.x + delta){
                between.push_back(point);
            }
        }
        int bn = between.size();
        for (int i = 0; i < bn; i++){
            for (int j = i + 1; j < min(i + 7, bn); j++){
                for (int k = j + 1; k < min(j + 7, bn); k++){
                    double dist = findDistance(between[i], between[j]) +
                                  findDistance(between[i], between[k]) + 
                                  findDistance(between[j], between[k]);
                    if (dist < delta) {
                        p1 = between[i];
                        p2 = between[j];
                        p3 = between[k];
                        delta = dist;
                    }    
                }
            }
        }
        return make_tuple(delta, p1, p2, p3);
    }
}

int main() {
    long long n;
    vector<Point> points;
    cin >> n;

    int x, y;
    while(n--){
        cin >> x >> y;
        points.push_back({x, y});
    }
   
    vector<Point> xSorted = sortByX(points);
    vector<Point> ySorted = sortByY(points);

    auto [min_dist, p1, p2, p3] = findSmallestTriangle(xSorted, ySorted);

    cout << p1.x << " " << p1.y << endl;
    cout << p2.x << " " << p2.y << endl;
    cout << p3.x << " " << p3.y << endl;
    return 0;
}