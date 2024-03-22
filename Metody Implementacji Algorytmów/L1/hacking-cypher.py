def check(n, a, b):
    x = [-1 for i in range(len(n))]
    y = [-1 for i in range(len(n))]

    x[0] = int(n[0]) % a
    y[len(n) - 1] = int(n[(len(n) - 1)]) % b

    for i in range(1, len(n)):
        x[i] = (10 * x[i - 1] + int(n[i])) % a
    
    t = 10
    for i in range(len(n) - 2, 0, -1):  
        y[i] = (t * int(n[i]) + y[i + 1]) % b
        t *= (10 % b) 

    for i in range(len(n) - 1): 
        if x[i] == 0 and y[i + 1] == 0 and n[i + 1] != '0':
            return i
    return -1

def main():
    num = str(input())
    a, b = map(int, input().split())

    i = check(num, a, b)
    if i != -1:
        print("YES")
        print(num[:i + 1])
        print(num[i + 1:])
    else:
        print("NO")

if __name__ == "__main__":
    main()
