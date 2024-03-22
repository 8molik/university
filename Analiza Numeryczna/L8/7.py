import matplotlib.pyplot as plt

x_values = [5.5, 8.5, 10.5, 13, 17, 20.5, 24.5, 28, 32.5, 37.5, 40.5, 42.5, 45, 47,
            49.5, 50.5, 51, 51.5, 52.5, 53, 52.8, 52, 51.5, 53, 54, 55, 56, 55.5, 54.5,
            54, 55, 57, 58.5, 59, 61.5, 62.5, 63.5, 63, 61.5, 59, 55, 53.5, 52.5, 50.5,
            49.5, 50, 51, 50.5, 49, 47.5, 46, 45.5, 45.5, 45.5, 46, 47.5, 47.5, 46, 43,
            41, 41.5, 41.5, 41, 39.5, 37.5, 34.5, 31.5, 28, 24, 21, 18.5, 17.5, 16.5, 15,
            13, 10, 8, 6, 6, 6, 5.5, 3.5, 1, 0, 0, 0.5, 1.5, 3.5, 5, 5, 4.5, 4.5, 5.5,
            6.5, 6.5, 5.5]

y_values = [41, 40.5, 40, 40.5, 41.5, 41.5, 42, 42.5, 43.5, 45, 47, 49.5, 53, 57, 59,
            59.5, 61.5, 63, 64, 64.5, 63, 61.5, 60.5, 61, 62, 63, 62.5, 61.5, 60.5, 60,
            59.5, 59, 58.5, 57.5, 55.5, 54, 53, 51.5, 50, 50, 50.5, 51, 50.5, 47.5, 44,
            40.5, 36, 30.5, 28, 25.5, 21.5, 18, 14.5, 10.5, 7.50, 4, 2.50, 1.50, 2, 3.50,
            7, 12.5, 17.5, 22.5, 25, 25, 25, 25.5, 26.5, 27.5, 27.5, 26.5, 23.5, 21, 19, 17,
            14.5, 11.5, 8, 4, 1, 0, 0.5, 3, 6.50, 10, 13, 16.5, 20.5, 25.5, 29, 33, 35, 36.5,
            39, 41]

n = len(x_values)
t_values = [k/95 for k in range(96)]

def eval_lambdas(ts):
    lambdas = [0]
    for k in range(1, 95):
        lambdas.append((ts[k] - ts[k - 1])/(ts[k + 1] - ts[k - 1]))
    return lambdas

def eval_pq(lambdas):
    p = [0]
    q = [0]

    for k in range(1, 95):
        p.append(lambdas[k] * q[k - 1] + 2)
        q.append((lambdas[k] - 1) / p[k])
    
    return p, q

def eval_h(x):
    h=[0]
    for i in range(1, len(x)):
        h.append(x[i] - x[i-1])
    return h

def eval_d(x, y):
    d = [0]
    for k in range(1, 95):
        f1 = (y[k + 1] - y[k]) / (x[k + 1] - x[k])
        f2 = (y[k] - y[k - 1]) / (x[k] - x[k - 1])
        d.append(6 * (f1 - f2)/(x[k + 1] - x[k - 1]))
    return d

def eval_u(d, p, lambdas):
    u = [0]
    for k in range(1, 95):
        u.append((d[k] - lambdas[k] * u[k - 1]) / p[k])
    return u

def eval_moments(u, q):
    m = [u[-1]]

    for k in range(1, 94):
        m.append(u[95 - k] + q[95 - k] * m[k - 1])

    m.append(0)
    return m[::-1]

def main_formula(t, x, y, m, h, k):
    return 1/h[k] * ((1/6 * m[k - 1] * (x[k] - t)**3)
                    + 1/6 * m[k] * (t - x[k - 1])**3
                    + (y[k - 1] - 1/6 * m[k - 1] * h[k]**2) * (x[k] - t)
                    + (y[k] - 1/6 * m[k] * h[k]**2) * (t - x[k - 1]))

def eval_s(x, y, p, q, lambdas, h):
    d = eval_d(x, y)
    u = eval_u(d, p, lambdas)
    m = eval_moments(u, q)

    ys = []
    k = 1
    for xk in x:
        ys.append(main_formula(xk, x, y, m, h, k))
        if k < len(x) - 2:
            k += 1                   
    return ys

def main():
    lambdas = eval_lambdas(t_values)
    p, q = eval_pq(lambdas)
    h = eval_h(t_values)

    x = eval_s(t_values, x_values, p, q, lambdas, h)
    y = eval_s(t_values, y_values, p, q, lambdas, h)

    plt.plot(x, y, color = 'blue')
    plt.show()

if __name__ == "__main__":
    main()
