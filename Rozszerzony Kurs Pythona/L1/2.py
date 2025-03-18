import re

def format_text(text):
    text = text.lower()
    text = re.sub(r'[^\w\s]', '', text)
    text = ''.join(text.split())
    return text

def is_palindrome(text):
    text = format_text(text)   
    return text == text[::-1]

print(is_palindrome("Eine güldne, gute Tugend: Lüge nie!"))
print(is_palindrome("Míč omočím."))
print(is_palindrome(",k a ; j a   :k "))
print(is_palindrome("to nie jest palindrom"))
