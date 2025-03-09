import random

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
    is_straight = True
    for i in range(1, len(hand)):
        if numbers.index(hand[i-1][0]) - numbers.index(hand[i][0]) != 1 or hand[i-1][1] != hand[i][1]:
            is_straight = False

    # 9 is the highest score
    if is_straight:
        return 9
    



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

calculate_hand_score(blotkarz_hand)
# calculate_hand_score(figurant_hand)