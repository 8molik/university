import random

# colors = ['spade', 'club', 'diamond', 'heart']
# figures = ['ace', 'jack', 'king', 'queen']

colors = ['pik', 'trefl', 'karo', 'kier']
numbers = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jopek', 'dama', 'krol', 'as']

figurant_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(9)]
blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(9, len(numbers))]

figurant_hand = random.sample(figurant_cards, 5)
blotkarz_hand = random.sample(blotkarz_cards, 5)

print(figurant_hand)
print(blotkarz_hand)

def calculate_hand_score(hand, owner='blotkarz'):
    hand = sorted(hand, key=lambda x: numbers.index(x[0]), reverse=True)
    


    print(hand)

calculate_hand_score(blotkarz_hand)
calculate_hand_score(figurant_hand, 'figurant')