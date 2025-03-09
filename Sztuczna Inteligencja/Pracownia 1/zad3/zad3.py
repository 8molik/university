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



def calculate_hand_score(hand):
    hand = sorted(hand, key=lambda x: numbers.index(x[0]), reverse=True)
    highest_card = hand[0]

    # Check if cards are straight
    card_counts = Counter(card[0] for card in hand)
    card_count_proportions = sorted([card_counts[i] for i in card_counts], reverse=True)
    print(card_count_proportions)
    print(card_counts)
    print(hand)
    is_straight = True
    same_color = True
    for i in range(1, len(hand)):
        if numbers.index(hand[i-1][0]) - numbers.index(hand[i][0]):
            is_straight = False
        if hand[i-1][1] != hand[i][1]:
            same_color = False

    print(is_straight)
    highest_card = hand[0][0]
    # 9 is the highest score
    if is_straight and same_color:
        return 9, highest_card
    if card_count_proportions == [4, 1]:
        # tutaj trzeba porównać oba rodzaje kart, wygrywa ten kto ma większy
        # dla uproszczenia wybieram najwyższy
        return 8, highest_card
    if card_count_proportions == [3, 2]:
        return 7, highest_card
    if card_count_proportions == [1, 1, 1, 1, 1] and same_color:
        return 6, highest_card
    if is_straight and not same_color: 
        # nie rozpatruję przypadku A 2 3 4 5
        return 5, highest_card
    if card_count_proportions == [3, 1, 1]:
        # trzeba dodać przypadek silniejszej trójki
        return 4, highest_card
    if card_count_proportions == [2, 2, 1]:
        # trzeba dodać moc dwójek
        return 3, highest_card
    



    print(hand)


def compare_strength(hand1, hand2):
    s1 = calculate_hand_score(hand1)
    s2 = calculate_hand_score(hand2)
    
    if s1 < s2:
        return s2
    elif s1 > s2:
        return s1
    else:
        return s1 if hand1[0] > hand2[0] else s2    

calculate_hand_score(figurant_hand)