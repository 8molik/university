import random

rows_number = 0
cols_number = 0
rows_specifications = []
cols_specifications = []

def read_input(file_path):
    global rows_specifications, cols_specifications, rows_number, cols_number

    with open(file_path, 'r') as file:
        rows_number, cols_number = map(int, file.readline().strip().split())

        for _ in range(rows_number):
            rows_specifications.append(map(int, file.readline().strip().split()))
        
        for _ in range(cols_number):
            cols_specifications.append(map(int, file.readline().strip().split()))


def unfilled_rows(grid):
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


rows_specifications = [[2, 2], [1, 1], [3]]
rows_number = 3
cols_number = 5

def main():
    #read_input('zad_input.txt')
    grid = [
        [1, 1, 0, 1, 1],
        [1, 0, 0, 1, 0],
        [1, 1, 1, 0, 0]
    ]

    
    print(unfilled_rows(grid))



main()