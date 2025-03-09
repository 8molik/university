import random
from collections import Counter

# colors = ['spade', 'club', 'diamond', 'heart']
# figures = ['ace', 'jack', 'king', 'queen']

colors = ['pik', 'trefl', 'karo', 'kier']
numbers = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'W', 'D', 'K', 'A']

figurant_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(9)]
blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(9, len(numbers))]

figurant_hand = random.sample(figurant_cards, 5)
blotkarz_hand = random.sample(blotkarz_cards, 5)

# Simplified rules
def calculate_hand_score(hand):
    hand = sorted(hand, key=lambda x: numbers.index(x[0]), reverse=True)
    card_counts = Counter(card[0] for card in hand)
    card_count_proportions = sorted([card_counts[i] for i in card_counts], reverse=True)

    is_straight = True
    same_color = True
    for i in range(1, len(hand)):
        if numbers.index(hand[i-1][0]) - numbers.index(hand[i][0]):
            is_straight = False
        if hand[i-1][1] != hand[i][1]:
            same_color = False
    if is_straight and same_color:
        return 9
    if card_count_proportions == [4, 1]:
        return 8
    if card_count_proportions == [3, 2]:
        return 7
    if card_count_proportions == [1, 1, 1, 1, 1] and same_color:
        return 6
    if is_straight and not same_color: 
        return 5
    if card_count_proportions == [3, 1, 1]:
        return 4
    if card_count_proportions == [2, 2, 1]:
        return 3
    if card_count_proportions == [2, 1, 1, 1]:
        return 2
    else:
        return 1

# We ignore rule of the strongest card, since 
# figurant cards are always stronger, than blotkarz cards
def compare_strength(blotkarz, figurant):
    s1 = calculate_hand_score(blotkarz)
    s2 = calculate_hand_score(figurant)
    return 'blotkarz' if s1 > s2 else 'figurant'

calculate_hand_score(figurant_hand)
calculate_hand_score(blotkarz_hand)
print(figurant_hand)
print(blotkarz_hand)

print(compare_strength(figurant_hand, blotkarz_hand))