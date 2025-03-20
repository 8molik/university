import random

def random_word_division(sentence, S):
    n = len(sentence)
    # dp[i] - czy można podzielić prefiks sentence[0:i]
    dp = [False] * (n + 1)
    dp[0] = True  # Pusty string można "podzielić"
    
    # przechowujemy poprzednie pozycje dla każdego i
    prev = [[] for _ in range(n + 1)]
    
    # Wypełniamy tablicę dp
    for i in range(1, n + 1):
        for j in range(i):
            if dp[j] and sentence[j:i] in S:
                dp[i] = True
                prev[i].append(j)
    
    # Jeśli nie można podzielić całego zdania
    if not dp[n]:
        return ""
    
    # Losowo odtwarzamy tekst
    result = []
    i = n
    while i > 0:
        # Wybieramy losowo jedną z możliwych poprzednich pozycji
        j = random.choice(prev[i])
        result.append(sentence[j:i])
        i = j
    
    result.reverse()
    return " ".join(result)

def main():
    with open('../Pracownia 1/zad2/words_for_ai.txt') as f:
        S = set()
        for line in f:
            S.add(line.strip())
    
    with open('../Pracownia 1/zad2/zad2_input.txt') as f, open('zad2_output_random.txt', 'w') as output:
        for line in f:
            sentence = random_word_division(line.strip(), S)
            output.write(sentence + '\n')

if __name__ == "__main__":
    main()