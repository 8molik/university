import requests
from bs4 import BeautifulSoup
import difflib
import time
from multiprocessing import Pool

def get_page_content(url):
    try:
        response = requests.get(url)
        return response.text
    except requests.exceptions.RequestException as e:
        print(f"Error while accessing page {url}: {e}")

def get_soup(url):
    page_content = get_page_content(url)
    soup = BeautifulSoup(page_content, "html.parser")

    for script in soup(["script", "style"]):
        script.extract() 
    return soup.get_text()

def to_string_difference(diff):
    res = ''
    for line in diff:
        if not line.isspace() and not line.startswith('*'):
            res += line.strip() + "\n"
    return res
        

def monitor_page(url):
    prev = get_soup(url)

    while True:
        time.sleep(10)
        soup = get_soup(url)
        if prev != soup:
            old = prev.splitlines()
            new = soup.splitlines()

            diff = difflib.context_diff(old, new)
            result = to_string_difference(diff)

            prev = soup
        else:
            result = "No changes"

        return result

def main():
    args = ["https://zapisy.ii.uni.wroc.pl", "https://skos.ii.uni.wroc.pl/my/", "https://www.onet.pl/"]

    while True:
        with Pool(3) as p:
            results = []
            for url in args:
                result = p.apply_async(monitor_page, (url,))
                results.append(result)

            for result in results:
                print(result.get())


if __name__ == "__main__":
    main()
