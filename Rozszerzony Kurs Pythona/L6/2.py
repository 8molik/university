import requests
from bs4 import BeautifulSoup
import difflib
import time

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

def print_differences(diff):
    print("Found changes: ")
    for line in diff:
        if not line.isspace() and not line.startswith('*'):
            print(line.lstrip())

def monitor_page(url):
    prev = get_soup(url)

    while True:
        soup = get_soup(url)
        if prev != soup:
            old = prev.splitlines()
            new = soup.splitlines()

            diff = difflib.context_diff(old, new)
            print_differences(diff)

            prev = soup
        else:
            print("No changes")
        time.sleep(10)

monitor_page("https://zapisy.ii.uni.wroc.pl")
