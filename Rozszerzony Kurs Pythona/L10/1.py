import matplotlib.pyplot as plt
import matplotlib.animation as animation
import random

global fig, ax
fig, ax = plt.subplots()
global squares
squares = [(random.randint(1, 9), random.randint(1, 9)) for _ in range(12)]

def main():
    global ani
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 10)
    ax.set_aspect('equal')

    ani = animation.FuncAnimation(fig, update, fargs=(), frames=snake_move(), repeat=False)
    plt.show()

def draw_squares(squares):
    for k in squares:
        ax.add_patch(plt.Rectangle((k[0], k[1]), 0.5, 0.5, color="black"))

def draw_snake(coordinates):
    for i in range(len(coordinates)):
        if (i % 2 == 0):
            ax.add_patch(plt.Rectangle((coordinates[i][0], coordinates[i][1]), 0.5, 0.5, color='green'))
        else:
            ax.add_patch(plt.Rectangle((coordinates[i][0], coordinates[i][1]), 0.5, 0.5, color='lightgreen'))

def snake_move():
    snake = [(5, 5), (5, 4.5), (5, 4), (5, 3.5), (5, 3)]
    directions = [(-0.5, 0), (0.5, 0), (0, 0.5), (0, -0.5)]

    while True:
        yield snake
        direction = random.choice(directions)
        new_head = (snake[0][0] + direction[0], snake[0][1] + direction[1])
        if new_head != snake[1]:  
            snake.insert(0, new_head)
            snake.pop()
    
def check_collision(snake):
    if (snake[0][0] < 0 or snake[0][0] > 10 or
        snake[0][1] < 0 or snake[0][1] > 10):
        return True
    
    for square in squares:
        if (snake[0][0] < square[0] + 0.5 and snake[0][0] + 0.5 > square[0] and
            snake[0][1] < square[1] + 0.5 and snake[0][1] + 0.5 > square[1]):
            return True

    if snake[0] in snake[1:]:
        return True
    
    return False

def update(frame):
    ax.clear()
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 10)
    ax.set_aspect('equal')
    draw_squares(squares)
    draw_snake(frame)

    if check_collision(frame):
        ani.event_source.stop()

main()
