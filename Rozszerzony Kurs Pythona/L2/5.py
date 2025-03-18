def compress(text):
    compressed_text = []
    letter_count = 1

    for i in range(len(text) - 1):
        if text[i] == text[i + 1]:
            letter_count += 1
        else:
            compressed_text.append((letter_count, text[i]))
            letter_count = 1
    compressed_text.append((letter_count, text[i]))

    return compressed_text
    
def decompress(compressed_text):
    return ''.join([x[0] * x[1] for x in compressed_text])

with open("Romeo.xml", 'r', encoding='utf-8') as text:
    text = text.read()
    compressed_text = compress(text)
    print(decompress(compressed_text))
