import math
from random import uniform

def pi_approximation(accuracy): 
    n = 1_000_000
    shots_in_circle = 0
    total_shots = 0

    for i in range(n):
        total_shots += 1
        pointX = uniform(-100, 100)
        pointY = uniform(-100, 100)
        
        if (math.sqrt(pointX ** 2 + pointY ** 2) <= 100):
            shots_in_circle += 1

        new_pi = 4 * shots_in_circle / total_shots
        print(f'{i}. {new_pi}')

        if(abs(new_pi - math.pi) < accuracy):
            break

pi_approximation(0.00001)
