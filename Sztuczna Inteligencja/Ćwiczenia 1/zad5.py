from math import comb
from collections import Counter
import itertools

colors = ['♠', '♦', '♣', '♥']
numbers = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'W', 'D', 'K', 'A']

blotkarz_cards = [(numbers[j], colors[i]) for i in range(len(colors)) for j in range(9)]
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


def count_distribution(cards):
    combinations = itertools.combinations(cards, 5)

    results = {i: 0 for i in range(1, 10)}
    total = 0

    for hand in combinations:
        score = calculate_hand_score(hand)
        results[score] += 1
        total += 1

    return results, total


def calculate_probabilities():
    figurant_distribution, figurant_hands_total = count_distribution(figurant_cards)
    blotkarz_distribution, blotkarz_hands_total = count_distribution(blotkarz_cards)

    figurant_probs = {i: score/figurant_hands_total for i, score in figurant_distribution.items()}
    blotkarz_probs = {i: score/blotkarz_hands_total for i, score in blotkarz_distribution.items()}

    blotkarz_win_prob = 0

    for i in range(1, 10):
        for j in range(1, i):
            blotkarz_win_prob += figurant_probs[j] * blotkarz_probs[i]

    return blotkarz_win_prob



def main():
    win_prob = calculate_probabilities()
    print("Blotkarz win probability:", win_prob)
                    
if __name__ == "__main__":
    main()
