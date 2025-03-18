# Program symuluje grę pokerową między dwoma graczami: Blotkarzem i Figurantem.
# Gracz Figurant losuje 5 kart z talii zawierającej asy, króle, damy i walety (wyższe karty),
# a Blotkarz losuje 5 kart z talii zawierającej pozostałe karty.
# Program porównuje siłę układów kart obu graczy, stosując uproszczone zasady pokerowe.

import random
from collections import Counter

colors = ['♠', '♦', '♣', '♥']
numbers = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'W', 'D', 'K', 'A']

blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(9)]
# blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(3)]
# blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(4)]
# blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(5)]
# blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(6)]

figurant_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(9, len(numbers))]

# Uproszczone zasady
def calculate_hand_score(hand):
    hand = sorted(hand, key=lambda x: numbers.index(x[0]), reverse=True)
    card_counts = Counter(card[0] for card in hand)
    card_count_proportions = sorted([card_counts[i] for i in card_counts], reverse=True)

    is_straight = True
    same_color = True
    for i in range(1, len(hand)):
        if numbers.index(hand[i-1][0]) - numbers.index(hand[i][0]) != 1:
            is_straight = False
        if hand[i-1][1] != hand[i][1]:
            same_color = False
    
    if is_straight and same_color:
        return 9
    if card_count_proportions == [4, 1]:
        return 8
    if card_count_proportions == [3, 2]:
        return 7
    if same_color: 
        return 6
    if is_straight:
        return 5
    if card_count_proportions == [3, 1, 1]:
        return 4
    if card_count_proportions == [2, 2, 1]:
        return 3
    if card_count_proportions == [2, 1, 1, 1]:
        return 2
    else:
        return 1

# Ignorujemy zasadę najsilniejszej karty, ponieważ
# karty Figuranta zawsze są silniejsze od kart Blotkarza. 
def compare_strength(blotkarz, figurant):
    blotkarz_score = calculate_hand_score(blotkarz)
    figurant_score = calculate_hand_score(figurant)
    return 'blotkarz' if blotkarz_score > figurant_score else 'figurant'


def main(n=100000, discard_count=0):
    figurant_wins = 0
    blotkarz_wins = 0 
    for i in range(n):
        figurant_hand = random.sample(figurant_cards, 5)
        blotkarz_hand = random.sample(blotkarz_cards, 5)
        # blotkarz_hand = [('10', '♠'), ('9', '♠'), ('8', '♠'), ('7', '♠'), ('6', '♠')] # 100% zwycięstw
        # blotkarz_hand = [('10', '♠'), ('3', '♠'), ('5', '♠'), ('6', '♠'), ('2', '♠')] # 92% zwycięstw
        # blotkarz_hand = [('10', '♠'), ('10', '♣'), ('10', '♥'), ('6', '♠'), ('2', '♠')] # 74% zwycięstw blotkarza
        # blotkarz_hand = [('10', '♠'), ('10', '♣'), ('10', '♥'), ('10', '♦'), ('2', '♠')] # 98% zwycięstw blotkarza
        # blotkarz_hand = [('2', '♠'), ('2', '♣'), ('2', '♥'), ('3', '♦'), ('3', '♠')] # 92% zwycięstw blotkarza

        blotkarz_hand = random.sample(blotkarz_hand, 5 - discard_count)
        remaining_cards = [card for card in blotkarz_cards if card not in blotkarz_hand]
        new_cards = random.sample(remaining_cards, discard_count)
        blotkarz_hand += new_cards

        calculate_hand_score(figurant_hand)
        calculate_hand_score(blotkarz_hand)

        if compare_strength(blotkarz_hand, figurant_hand) == 'blotkarz':
            blotkarz_wins += 1
        else: 
            figurant_wins += 1
                    
    print(blotkarz_wins, figurant_wins)
    print(f"Blotkarz wins: {blotkarz_wins/n}")
    print(f"Figurant wins: {figurant_wins/n}")

main()
