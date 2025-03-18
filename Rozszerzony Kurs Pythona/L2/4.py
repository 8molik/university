from random import randint

def simplify(text, max_word_length, words_number):
    text = text.split()
    simplified_text = []

    for word in text:    
        word_length = len(word)
        if word_length <= max_word_length:
            simplified_text.append(word)    

    while len(simplified_text) > words_number:
        simplified_text.pop(randint(0, len(simplified_text) - 1))

    return simplified_text

tekst = "Podział peryklinalny inicjałów wrzecionowatych kambium charakteryzuje się ścianą podziałową inicjowaną w płaszczyźnie maksymalnej."
result = simplify(tekst, 10, 5)
print(result)

with open("Romeo.xml", "r", encoding='utf-8') as f:
    f = f.read()
    result = simplify(f, 10, 50)
    print(result)
    