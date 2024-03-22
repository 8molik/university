import matplotlib.pyplot as plt
import numpy as np

def bernstein_poly(i, n, t):
    return np.math.comb(n, i) * (t**(n-i)) * ((1-t)**i)

def bezier_curve(control_points, weights, num_points=1000):
    n = len(control_points) - 1
    t_values = np.linspace(0, 1, num_points)
    curve_points = np.zeros((num_points, 2))

    for i, t in enumerate(t_values):
        point = np.zeros(2)
        for j in range(n + 1):
            point += weights[j] * bernstein_poly(j, n, t) * control_points[j]
        curve_points[i] = point

    return curve_points

# Punkty kontrolne
control_points = np.array([(0, 0), (3.5, 36), (25, 25), (25, 1.5), (-5, 3), (-5, 33),
                           (15, 11), (-0.5, 35), (19.5, 15.5), (7, 0), (1.5, 10.5)])

# Wagi
weights = [1, 6, 4, 2, 3, 4, 2, 1, 5, 4, 1]

# Rysowanie krzywej Béziera
curve_points = bezier_curve(control_points, weights)
plt.plot(control_points[:, 0], control_points[:, 1], 'ro-', label='Punkty kontrolne')
plt.plot(curve_points[:, 0], curve_points[:, 1], 'b-', label='Krzywa Béziera')
plt.title('Krzywa Béziera z podanymi punktami kontrolnymi i wagami')
plt.legend()
plt.show()
