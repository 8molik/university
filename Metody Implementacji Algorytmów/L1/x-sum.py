def check_sum(i, j, board):
    x, y = i, j
    s = 0
    
    while x < len(board[0]) and y < len(board):
        s += board[y][x]
        x += 1
        y += 1

    x, y = i, j

    while x < len(board[0]) and y >= 0: #>= bo indeksujemy do zera, < bo len zwraca długość
        s += board[y][x]
        x += 1
        y -= 1

    x, y = i, j

    while x >= 0 and y < len(board):
        s += board[y][x]
        x -= 1
        y += 1

    x, y = i, j

    while x >= 0 and y >= 0:
        s += board[y][x]
        x -= 1
        y -= 1
    
    return s - 3 * board[j][i]
    
def check_all(board):
    sums = []

    for row in range(len(board)):
        for col in range(len(board[0])):
            sums.append(check_sum(col, row, board))

    return max(sums)

def main():
    t = int(input())
    
    for e in range(t):
        n, m = map(int, input().split())
        board = []

        for e in range(n):
            row = list(map(int, input().split()))
            board.append(row)

        result = check_all(board)
        print(result)

if __name__ == "__main__":
    main()