# colors = ['spade', 'club', 'diamond', 'heart']
# figures = ['ace', 'jack', 'king', 'queen']

colors = ['pik', 'trefl', 'karo', 'kier']
figures = ['as', 'jopek', 'krol', 'dama']
numbers = ['2', '3', '4', '5', '6', '7', '8', '9', '10']

figurant_cards = [(colors[i], figures[j]) for i in range(len(colors)) for j in range(len(figures))]
blotkarz_cards = [(colors[i], numbers[j]) for i in range(len(colors)) for j in range(len(numbers))]
 
print(figurant_cards)
print(blotkarz_cards)

