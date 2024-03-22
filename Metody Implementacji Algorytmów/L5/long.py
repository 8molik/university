def main():
    n, l, x, y = map(int, input().split())
    marks = list(map(int, input().split()))

    positions = set(marks)
    solved1 = False
    solved2 = False

    for mark in marks:
        if (mark - x in positions or mark + x in positions):
            solved1 = True

        if (mark - y in positions or mark + y in positions):
            solved2 = True

        if solved1 and solved2:
            break

    if solved1 and solved2:
        print("0")
    else:
        if solved1:
            print("1")
            print(marks[0] + y)
        elif solved2:
            print("1")
            print(marks[0] + x)
        else:
            ans = []

            for i in range(n):
                p = marks[i] - x

                if 0 <= p <= l and (p - y in positions or p + y in positions):
                    ans.append(p)
                    break

                p = marks[i] + x

                if 0 <= p <= l and (p - y in positions or p + y in positions):
                    ans.append(p)
                    break

            if not ans:
                ans.extend([marks[0] + y, marks[0] + x])

            print(len(ans))
            print(*ans)

if __name__ == "__main__":
    main()
