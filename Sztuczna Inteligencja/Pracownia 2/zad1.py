import random

def opt_dist(line, D):
    n = len(line)
    l = r = 0
    ones_inside = zeros_inside = ones_outside = 0

    for i in range(n):
        if line[i] == 1:
            ones_outside += 1

    while r < D:
        if line[r] == 0:
            zeros_inside += 1
        else: 
            ones_inside += 1
            ones_outside -= 1
        r += 1

    result = zeros_inside + ones_outside
    while r < n:
        if line[l] == 1:
            ones_inside -= 1
            ones_outside += 1
        if line[l] == 0:
            zeros_inside -= 1

        if line[r] == 0:
            zeros_inside += 1
        if line[r] == 1:
            ones_inside += 1
            ones_outside -= 1
        l += 1
        r += 1
        
        result = min(result, zeros_inside + ones_outside)

    return result


def initialize_grid(rows, cols):
    grid = []
    for i in range(rows):
        tmp = []
        for j in range(cols):
            tmp.append(0)
        grid.append(tmp)
    return grid


def is_row_valid(row, row_spec):
    if row_spec == 0:
        return sum(row) == 0
    
    blocks = 0
    current_block_len = 0
    for bit in row:
        if bit == 1:
            current_block_len += 1
        elif current_block_len > 0:
            blocks += current_block_len
            current_block_len = 0
    
    if current_block_len > 0:
        blocks += current_block_len
    
    return blocks == row_spec


def solve_nonogram(rows_spec, cols_spec, rows, cols, grid, max_iterations=1000):
    i = 0
    no_improvement_count = 0

    while i < max_iterations:
        i += 1

        # Sprawdź czy rozwiązano nonogram
        rows_valid = all(is_row_valid([grid[i][j] for j in range(cols)], rows_spec[i]) for i in range(rows))
        cols_valid = all(is_row_valid([grid[i][j] for i in range(rows)], cols_spec[j]) for j in range(cols))
        if rows_valid and cols_valid:
            return grid
        
        # Jeżeli nie ma poprawy - losujemy od nowa
        if no_improvement_count >= 100:
            grid = [[random.randint(0, 1) for _ in range(cols)] for _ in range(rows)]
            no_improvement_count = 0
            continue
        
        invalid_rows = [i for i in range(rows) if not is_row_valid([grid[i][j] for j in range(cols)], rows_spec[i])]
        invalid_cols = [j for j in range(cols) if not is_row_valid([grid[i][j] for i in range(rows)], cols_spec[j])]
        
        # Naprawiamy wiersz
        if invalid_rows and (not invalid_cols or random.random() < 0.5):
            # Wybierz randomowy wiersz
            row_idx = random.choice(invalid_rows)
            best_improvement = -float('inf')
            best_col = -1
            
            current_row = [grid[row_idx][j] for j in range(cols)]
            current_row_dist = opt_dist(current_row, rows_spec[row_idx])
            
            # Przejdź po kolumnach i znajdź optymalny bit
            for col_idx in range(cols):
                new_row = current_row.copy()
                new_row[col_idx] = 1 - new_row[col_idx]
                
                # Oblicz poprawę
                row_improvement = current_row_dist - opt_dist(new_row, rows_spec[row_idx])
                
                # Sprawdź wpływ na kolumnę
                current_col = [grid[i][col_idx] for i in range(rows)]
                current_col_dist = opt_dist(current_col, cols_spec[col_idx])
                
                new_col = current_col.copy()
                new_col[row_idx] = 1 - new_col[row_idx]
                col_improvement = current_col_dist - opt_dist(new_col, cols_spec[col_idx])
                
                total_improvement = row_improvement + col_improvement
                
                if total_improvement > best_improvement:
                    best_improvement = total_improvement
                    best_col = col_idx
            
            if best_col != -1:
                grid[row_idx][best_col] = 1 - grid[row_idx][best_col]
                if best_improvement > 0:
                    no_improvement_count = 0
                else:
                    no_improvement_count += 1

        # Naprawiamy kolumnę
        else:
            col_idx = random.choice(invalid_cols)
            best_improvement = -float('inf')
            best_row = -1
            
            current_col = [grid[i][col_idx] for i in range(rows)]
            current_col_dist = opt_dist(current_col, cols_spec[col_idx])
            
            for row_idx in range(rows):
                new_col = current_col.copy()
                new_col[row_idx] = 1 - new_col[row_idx]
                
                col_improvement = current_col_dist - opt_dist(new_col, cols_spec[col_idx])
                
                current_row = [grid[row_idx][j] for j in range(cols)]
                current_row_dist = opt_dist(current_row, rows_spec[row_idx])
                
                new_row = current_row.copy()
                new_row[col_idx] = 1 - new_row[col_idx]
                row_improvement = current_row_dist - opt_dist(new_row, rows_spec[row_idx])
                
                total_improvement = col_improvement + row_improvement
                
                if total_improvement > best_improvement:
                    best_improvement = total_improvement
                    best_row = row_idx
            
            if best_row != -1:
                grid[best_row][col_idx] = 1 - grid[best_row][col_idx]
                if best_improvement > 0:
                    no_improvement_count = 0
                else:
                    no_improvement_count += 1
    
    return grid


def load_file(path):
    rows_spec = []
    cols_spec = []
    rows, cols = 0, 0
    with open(path, 'r') as f:
        f = f.readlines()
        rows, cols = map(int, f[0].split())

        for i in range(1, rows + 1):
            rows_spec.append(int(f[i].strip()))
        
        for j in range(rows + 1, rows + cols + 1):
            cols_spec.append(int(f[j].strip()))
    
    return rows_spec, cols_spec, rows, cols


def main():
    rows_spec, cols_spec, rows, cols = load_file('zad5_input.txt') 
    starting_grid = initialize_grid(rows, cols)
    
    solution = solve_nonogram(rows_spec, cols_spec, rows, cols, starting_grid)
    
    with open('zad5_output.txt', 'w') as f:
        for row in solution:
            f.write(''.join(['#' if bit == 1 else '.' for bit in row]) + '\n')

if __name__ == "__main__":
    main()
