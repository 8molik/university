n, p = map(int, input().split())
s = input()

can_change = 0
index = 0

for i in range(n - 1, -1, -1):
    position = ord(s[i]) - ord('a') + 1
    for j in range(position, p):
        if (i >= 1 and ord(s[i - 1]) - ord('a') == j) or (i >= 2 and ord(s[i - 2]) - ord('a') == j):
            continue
        s = s[:i] + chr(j + ord('a')) + s[i + 1:]
        can_change = 1
        index = i + 1
        break
    if can_change == 1:
        break

if can_change == 0:
    print("NO")
    exit()

for i in range(index, n):
    for j in range(p):
        if (i >= 1 and ord(s[i - 1]) - ord('a') == j) or (i >= 2 and ord(s[i - 2]) - ord('a') == j):
            continue
        s = s[:i] + chr(j + ord('a')) + s[i + 1:]
        break

print(s)
