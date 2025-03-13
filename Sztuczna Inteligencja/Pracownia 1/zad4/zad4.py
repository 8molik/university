# Program implementuje funkcję opt_dist, która minimalizuje 
# liczbę zmian bitów (0 ↔ 1) w ciągu binarnym, tak
# aby utworzyć dokładnie jeden blok jedynek o długości D.

def opt_dist(line, D):
    n = len(line)
    l = r = 0

    ones_inside = zeros_inside = ones_outside = 0

    for i in range(n):
        if line[i] == '1':
            ones_outside += 1

    while r < D:
        if line[r] == '0':
            zeros_inside += 1
        else: 
            ones_inside += 1
            ones_outside -= 1
        r += 1

    result = zeros_inside + ones_outside
    while r < n:
        if line[l] == '1':
            ones_inside -= 1
            ones_outside += 1
        if line[l] == '0':
            zeros_inside -= 1

        if line[r] == '0':
            zeros_inside += 1
        if line[r] == '1':
            ones_inside += 1
            ones_outside -= 1
        l += 1
        r += 1
        
        result = min(result, zeros_inside + ones_outside)

    return result

def main():
    with open("zad4_input.txt", "r") as f1:
        with open("zad4_output.txt", "w") as f2:
            for line in f1:
                line = line.split()
                print(opt_dist(line[0], int(line[1])), file=f2)

main()