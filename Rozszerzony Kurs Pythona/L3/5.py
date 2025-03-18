from math import inf

def max_sublist_sum(xs):
    start =  end = j = 0
    max_sum = -inf
    curr_sum = 0

    for i in range(0, len(xs)):
        
        if curr_sum < 0:
            curr_sum = 0
            j = i

        curr_sum += xs[i]

        if curr_sum > max_sum:
            max_sum = curr_sum
            start = j
            end = i          
        
    return (start, end)

xs = [-3, 2, -5, 5, -1, 2, -5, 20]
s = max_sublist_sum(xs)

print(s)
