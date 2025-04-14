import random

rows_number = 0
cols_number = 0
rows_specifications = []
cols_specifications = []
bit_swaps_memo = {}


def read_input(file_path):
    global rows_specifications, cols_specifications, rows_number, cols_number

    with open(file_path, 'r') as file:
        rows_number, cols_number = map(int, file.readline().strip().split())

        for _ in range(rows_number):
            rows_specifications.append(map(int, file.readline().strip().split()))
        
        for _ in range(cols_number):
            cols_specifications.append(map(int, file.readline().strip().split()))


def get_unfilled_rows(grid):
    global rows_specifications, rows_number, cols_number

    rows = set()

    for i in range(rows_number):
        current_row = grid[i]
        block_lengths = []
        block = 0

        for val in current_row:
            if val == 1:
                block += 1
            elif block > 0:
                block_lengths.append(block)
                block = 0
        if block > 0: 
            block_lengths.append(block)

        if block_lengths != rows_specifications[i]:
            rows.add(i)

    return rows


def get_unfilled_cols(grid):
    global cols_specifications, rows_number, cols_number

    cols = set()

    for i in range(cols_number):
        block_lengths = []
        block = 0

        for j in range(rows_number):
            val = grid[j][i]
            if val == 1:
                block += 1
            elif block > 0:
                block_lengths.append(block)
                block = 0
        if block > 0:
            block_lengths.append(block)

        if block_lengths != cols_specifications[i]:
            cols.add(i)

    return cols



def minimal_number_of_bits_swaps(line, line_hints):
    line = list(line)
    
    # Sprawdzenie, czy taki wiersz/kolumna był już obliczony
    curr_pair = (tuple(line), tuple(line_hints))
    if curr_pair in bit_swaps_memo:
        return bit_swaps_memo[curr_pair]
    
    line = [0] + line
    
    # Macierz do obliczeń DP
    dp = [[float('inf') for i in range(len(line) + 1)] for j in range(len(line_hints) + 1)]
    
    ones = 0
    for j in range(len(line)):
        dp[0][j] = ones
        if line[j] == 1:
            ones += 1

    for i in range(1, len(line_hints) + 1):
        for j in range(len(line) + 1):
            # Opcja 1: Kontynuacja z poprzedniej pozycji plus koszt dodania bieżącego bitu
            option1 = dp[i][j - 1] + line[j - 1]
            
            # Opcja 2: Użycie bieżącego hinta
            current_hint = line_hints[i - 1]
            prev_position = j - current_hint - 1
            
            # Obliczenie kosztu
            bits_in_segment = sum(line[j - current_hint: j])
            cost_to_place_hint = current_hint - bits_in_segment  # ile jedynek trzeba dodać
            cost_of_prev_zero = line[prev_position]  # koszt zerowania pozycji przed segmentem
            
            option2 = dp[i - 1][prev_position] + cost_to_place_hint + cost_of_prev_zero
            
            dp[i][j] = min(option1, option2)
    
    result = dp[len(line_hints)][len(line)]
    bit_swaps_memo[curr_pair] = result
    
    return result


def solve():
    global rows_specifications, cols_specifications, rows_number, cols_number, bit_swaps_memo

    # Przypisz losowe wartości do macierzy nonogramu
    grid = [[random.randint(0, 1) for _ in range(cols_number)] for _ in range(rows_number)]
    
    unfilled_rows = get_unfilled_rows(grid)
    unfilled_cols = get_unfilled_cols(grid)

    # Zmienna do śledzenia liczby iteracji
    iterations = 0

    while unfilled_rows or unfilled_cols:
        if iterations > 1000:
            solve()

        iterations += 1

        if unfilled_rows and random.randint(0, 1) == 1:
            row_to_fix = random.choice(unfilled_rows)


        else:
            pass


rows_specifications = [[2, 2], [1, 1], [3]]
cols_specifications = [[3], [1, 1], [21], [2], [1]]

rows_number = 3
cols_number = 5

def main():
    #read_input('zad_input.txt')
    grid = [
        [1, 1, 0, 1, 1],
        [1, 0, 0, 1, 0],
        [1, 1, 1, 0, 0]
    ]
    # solve()


main()