
WALL = '#'
GOAL = 'G'
START = 'S'
START_GOAL = 'B'
EMPTY_FIELD = ' '

DIRECTIONS = ['U', 'D', 'L', 'R']

steps = []
starting_positions = set()
labirynth = []
goals = []

def load_input(filename):
    global labirynth
    height, width = 0, 0
    with open(filename, 'r') as f:
        for line in f:
            labirynth.append(list(line.strip()))

        height = len(labirynth)
        width = len(labirynth[0])

    return height, width


def parse_input(height, width):
    global labirynth, starting_positions
    for i in range(height):
        for j in range(width):
            if labirynth[i][j] == GOAL:
                goals.append((i, j))
            if labirynth[i][j] == START:
                starting_positions.add((i, j))
            if labirynth[i][j] == START_GOAL:
                starting_positions.add((i, j))
                goals.append((i, j))


def make_move(position, direction):
    global labirynth
    move = (0, 0)
    if direction == 'U':
        move = (-1, 0)
    elif direction == 'D':
        move = (1, 0)
    elif direction == 'L':
        move = (0, -1)
    elif direction == 'R':
        move = (0, 1)
   
    new_position = (position[0] + move[0], position[1] + move[1])

    if labirynth[new_position[0]][new_position[1]] == WALL:
        return position

    return new_position


def move_all(direction):
    positions = set()
    for pos in starting_positions:
        new_pos = make_move(pos, direction)
        
        positions.add(new_pos)

    return positions
        

def main():
    global starting_positions
    height, width = load_input('2.txt')

    parse_input(height, width)
    
    print(starting_positions)
    

    print("\n")
    print(starting_positions)

if __name__ == '__main__':
    main()