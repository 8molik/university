def compare_files(p1, p2):
    with open(p1, 'r', encoding='utf-8') as plik1:
        p1_lines = plik1.readlines()
    
    with open(p2, 'r', encoding='utf-8') as plik2:
        p2_lines = plik2.readlines()
    
    same_lines = 0 
    for i in range(len(p2_lines)-1):
        if p1_lines[i] == p2_lines[i]:
            same_lines += 1
            
    return same_lines / len(p2_lines) * 100
        

def main():
    wynik = compare_files("../Pracownia 1/zad2/zad2_output.txt", "pan_tadeusz_bez.txt")
    print(wynik)
    wynik = compare_files("zad3_output_random.txt", "pan_tadeusz_bez.txt")
    print(wynik)

if __name__ == "__main__":
    main()