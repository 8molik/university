n, q = map(int, input().split())

arr = [0] + list(map(int, input().split()))
q_start = [0] * (n + 1)
q_end = [0] * (n + 1)

for k in range(q):
    li, ri = map(int, input().split())
    q_start[li] += 1

    if ri + 1 <= n:
        q_end[ri + 1] += 1

q_index = 0
index_queried = [0] * (n + 1)

for i in range(1, n + 1):
    q_index += (q_start[i] - q_end[i])
    index_queried[i] = q_index

arr.sort()
index_queried.sort()

maximum_sum = sum(index_queried[i] * arr[i] for i in range(1, n + 1))
print(maximum_sum)
