import pygame
import sys

# Initialize Pygame
pygame.init()
width, height = 1280, 720

# Game window settings
screen = pygame.display.set_mode((width, height))

# Colors
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
RED = (255, 0, 0)
POINT_RADIUS = 8

all_curves = [] 

# List of control points for the current curve
control_points = []
selected_point = None
selected_point_curve = None
selected_curve = None
running = True
drawing = False
button_width, button_height = 150, 40
button_color = (0, 255, 255)  # Green color for the button
button_margin = 10  # Adjust this value to control the distance between buttons

button_z_rect = pygame.Rect(10, height - button_height - 10, button_width, button_height)
button_x_rect = pygame.Rect(button_z_rect.right + button_margin, height - button_height - 10, button_width, button_height)
button_space_rect = pygame.Rect(button_x_rect.right + button_margin, height - button_height - 10, button_width, button_height)
button_c_rect = pygame.Rect(button_space_rect.right + button_margin, height - button_height - 10, button_width, button_height)
button_print_rect = pygame.Rect(button_c_rect.right + button_margin, height - button_height - 10, 150, button_height)
button_remove_point_rect = pygame.Rect(button_print_rect.right + button_margin, height - button_height - 10, 150, button_height)
button_connect_rect = pygame.Rect(button_remove_point_rect.right + button_margin, height - button_height - 10, button_width, button_height)


remove_flag = False
connect_flag = False

def draw_bezier_curve(control_points):
    n = len(control_points)
    if n < 2:
        return []
    curve_points = []
    for t in range(0, 101):
        t /= 100.0
        points = control_points.copy()
        while len(points) > 1:
            new_points = []
            for i in range(len(points) - 1):
                x = (1 - t) * points[i][0] + t * points[i + 1][0]
                y = (1 - t) * points[i][1] + t * points[i + 1][1]
                new_points.append((x, y))
            points = new_points
        curve_points.append(points[0])
    pygame.draw.lines(screen, RED, False, curve_points, 3)

def draw_current_points():
    for i, point in enumerate(control_points):
        color = BLACK if i == selected_point else RED
        pygame.draw.circle(screen, color, point, POINT_RADIUS)

# Function to draw all curves
def draw_all_curves(all_curves):    
    for curve in all_curves: 
        draw_bezier_curve(curve)
    for curve in all_curves:
        for point in curve:
            pygame.draw.circle(screen, BLACK, point, POINT_RADIUS)

# Function to draw buttons
def draw_buttons():
    def draw_button(rect, text, clicked = False):
        if clicked:
            pygame.draw.rect(screen, (100, 255, 255), rect)
        else:
            pygame.draw.rect(screen, button_color, rect)
        font = pygame.font.SysFont("Arial", 20)
        text_surface = font.render(text, True, WHITE)
        text_rect = text_surface.get_rect(center=rect.center)
        screen.blit(text_surface, text_rect)

    draw_button(button_z_rect, "Usuń punkt")
    draw_button(button_x_rect, "Usuń krzywą")
    draw_button(button_space_rect, "Dodaj krzywą")
    draw_button(button_c_rect, "Kąt")
    draw_button(button_print_rect, "Wypisz krzywe")
    if remove_flag:
        draw_button(button_remove_point_rect, "Usuń punkty", True)
    else:
        draw_button(button_remove_point_rect, "Usuń punkty")
    draw_button(button_connect_rect, "Dołącz")

# Function to handle keyboard and mouse events
def handle_events():
    global selected_point, control_points

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            print("All Curves:", all_curves)
            sys.exit()
        elif event.type == pygame.MOUSEBUTTONDOWN:
            handle_mouse_button_down(event)
            handle_button_click()
        elif event.type == pygame.MOUSEBUTTONUP:
            handle_mouse_button_up(event)
        elif event.type == pygame.KEYDOWN:
            handle_keydown(event)

# Function to handle mouse button press
def handle_mouse_button_down(event):
    global selected_point, selected_point_curve, selected_curve, control_points, remove_flag, connect_flag

    if event.button == 1:
        if (button_z_rect.collidepoint(event.pos) or
            button_x_rect.collidepoint(event.pos) or
            button_space_rect.collidepoint(event.pos) or
            button_c_rect.collidepoint(event.pos) or
            button_print_rect.collidepoint(event.pos) or
            button_remove_point_rect.collidepoint(event.pos) or
            button_connect_rect.collidepoint(event.pos)):
            return 
        for i, point in enumerate(control_points):
            if pygame.math.Vector2(point).distance_to(event.pos) < POINT_RADIUS:
                selected_point = i
                break
        else:
            control_points.append(event.pos)
        for j in range(len(all_curves)):
            for i, point in enumerate(all_curves[j]):
                if pygame.math.Vector2(point).distance_to(event.pos) < POINT_RADIUS:
                    selected_point_curve = i
                    selected_curve = j
                    break
        if connect_flag:
            for j in range(len(all_curves)):
                for i, point in enumerate(all_curves[j]):
                    if pygame.math.Vector2(point).distance_to(event.pos) < POINT_RADIUS:
                        if len(control_points) > 1:
                            all_curves[j] += control_points
                        control_points = []
                        break
            connect_flag = False
                        
    if event.button == 3:
        if not remove_flag:
            for j in range(len(all_curves)):
                for i, point in enumerate(all_curves[j]):
                    if pygame.math.Vector2(point).distance_to(event.pos) < POINT_RADIUS:
                        control_points = [all_curves[j][i]]
        else:
            for j in range(len(all_curves)):
                for i, point in enumerate(all_curves[j]):
                    if pygame.math.Vector2(point).distance_to(event.pos) < POINT_RADIUS:
                        all_curves[j].remove(point)
                    
# Function to handle mouse button release
def handle_mouse_button_up(event):
    global selected_point, selected_point_curve, selected_curve

    if event.button == 1 and selected_point is not None:
        selected_point = None
    if event.button == 1 and selected_point_curve is not None:
        selected_point_curve = None
        selected_curve = None

# Function to handle key press
def handle_keydown(event):
    global last_point, selected_point, control_points, all_curves

    if event.key == pygame.K_SPACE:
        if len(control_points) > 1:
            all_curves.append(control_points.copy()) 
        draw_all_curves(all_curves) 
        control_points = []
        selected_point = None
    
    elif event.key == pygame.K_c:       
        if  len(control_points) > 1:
            last_point = control_points[len(control_points) - 1]
            all_curves.append(control_points.copy()) 
            control_points = [last_point]
        draw_all_curves(all_curves) 
        
    elif event.key == pygame.K_z:
        if len(control_points) > 0:
            control_points.pop()
            draw_all_curves(all_curves) 

    elif event.key == pygame.K_x:
        if len(all_curves) > 0: 
            all_curves.pop() 
            draw_all_curves(all_curves) 

# Function to handle button clicks
def handle_button_click():
    global all_curves, control_points, last_point, remove_flag, connect_flag

    if button_z_rect.collidepoint(pygame.mouse.get_pos()):
        if len(control_points) > 0:
            control_points.pop()
    elif button_x_rect.collidepoint(pygame.mouse.get_pos()):
        if len(all_curves) > 0:
            all_curves.pop()
    elif button_space_rect.collidepoint(pygame.mouse.get_pos()):
        if len(control_points) > 1:
            all_curves.append(control_points.copy())
        control_points = []
    elif button_c_rect.collidepoint(pygame.mouse.get_pos()):
        if  len(control_points) > 1:
            all_curves.append(control_points.copy()) 
            last_point = control_points[len(control_points) - 1]
            control_points = [last_point]
        draw_all_curves(all_curves) 
    elif button_remove_point_rect.collidepoint(pygame.mouse.get_pos()):
        remove_flag = not remove_flag
    elif button_connect_rect.collidepoint(pygame.mouse.get_pos()):
        connect_flag = True
    elif button_print_rect.collidepoint(pygame.mouse.get_pos()):
        print("All Curves:", all_curves)

# Function to handle moving the selected control point
def move_selected_point():
    global selected_point, control_points, selected_point_curve, selected_curve
    
    if selected_point is not None:
        control_points[selected_point] = pygame.mouse.get_pos()
    elif selected_point_curve is not None:
        all_curves[selected_curve][selected_point_curve] = pygame.mouse.get_pos()
        screen.fill(WHITE)
        draw_all_curves(all_curves)
        selected_point = None
        control_points = []

while running:
    handle_events()
    
    screen.fill(WHITE)
    draw_all_curves(all_curves) 
    draw_bezier_curve(control_points)
    draw_current_points()
    draw_buttons()

    pygame.display.flip()
    move_selected_point()