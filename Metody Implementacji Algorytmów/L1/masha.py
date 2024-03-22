def find(num, xs):
    if len(num) == 0:
        return True
    if len(xs) == 0:
        return False
    else:
        for i in range(len(xs)):
            for j in range(len(xs[i])):
                if str(xs[i][j]) == num[0]:
                    if find(num[1:], xs[:i] + xs[i+1:]):
                        return True
    return False

def main():
    cubes = []
    for i in range(int(input())):
        cubes.append(list(map(str, input().split())))
    
    i = 1
    while True:
        if find(str(i), cubes):
            i += 1
        else:
            print(i - 1)
            break

if __name__ == "__main__":
    main()