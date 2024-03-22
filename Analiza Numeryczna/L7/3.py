import numpy as np
import matplotlib.pyplot as plt
import math

def regularne(n):
    tab = []
    x = 0
    for k in range(n + 1):
        tab.append(-1 + x)
        x += 2 / n

    return tab

def czebyszew(n):
    tab = []
    for k in range(n + 1):
        x = math.cos((2*k+1)/(2*n+2) * math.pi)
        tab.append(x)

    return tab

def fun(x, tab):
    result = 1.0
    for xi in tab:
        result *= (x - xi)
    return result

degree_range = range(16, 17)

x = np.linspace(-1, 1, 1000)

fig, axes = plt.subplots(2, 1, figsize=(15, 10))
fig.suptitle("Wielomiany dla węzłów równoodległych i Czebyszewa", fontsize=16)

for degree in degree_range:
    y_regular = fun(x, regularne(degree))
    axes[0].plot(x, y_regular, label=f'n={degree}')

axes[0].set_title('Węzły równoodległe')
axes[0].legend()

for degree in degree_range:
    y_czebyszew = fun(x, czebyszew(degree))
    axes[1].plot(x, y_czebyszew, label=f'n={degree}')

axes[1].set_title('Węzły Czebyszewa')
axes[1].legend()

plt.show()