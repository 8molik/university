def find_all_words(sentence, S):
    """Function finds best way to split given sentence."""
    n = len(sentence)

    # dp[i] - Maksymalna suma kwadratów długości słów dla prefiksu od 0 do i, jeśli istnieje podział
    dp = [-1] * (n + 1)
    dp[0] = 0

    # Indeksy dobrych podziałów
    split_indices = [None] * (n + 1)

    for i in range(1, n + 1):
        for j in range(i):
            word = sentence[j:i]
            
            if word in S:
                word_cost = len(word) ** 2 + dp[j]
                if word_cost > dp[i]:
                    dp[i] = word_cost 
                    split_indices[i] = j 
    
    if dp[n] == -1:
        return ""

    # Odtworzenie tekstu
    result = []
    i = n
    while i > 0:
        j = split_indices[i]
        if j is None:
            break
        result.append(sentence[j:i])
        i = j

    result.reverse()
    return " ".join(result)

def main():
    with open('words_for_ai.txt') as f:
        S = set()
        for line in f:
            S.add(line.strip())

    with open('zad2_input.txt') as f, open('zad2_output.txt', 'w') as output:
        for line in f:
            sentence = find_all_words(line.strip(), S)
            output.write(sentence + '\n')

if __name__ == "__main__":   
    main()