import requests
import argparse

API_URL = "http://localhost:3000/api"

def print_books(books):
    for book in books:
        print(f"ID: {book['id']}, Author: {book['author']}, Title: {book['title']}, Release Year: {book['release_year']}")

def print_friends(friends):
    for friend in friends:
        print(f"ID: {friend['id']}, Name: {friend['name']}, Email: {friend['email']}")

def add_book(author, title, release_year):
    data = {'author': author, 'title': title, 'release_year': release_year}
    response = requests.post(f"{API_URL}/books", json=data)
    result = response.json()
    print(result['message'])

def add_friend(name, email):
    data = {'name': name, 'email': email}
    response = requests.post(f"{API_URL}/friends", json=data)
    result = response.json()
    print(result['message'])

def update_book(book_id, author=None, title=None, release_year=None):
    data = {}
    if author:
        data['author'] = author
    if title:
        data['title'] = title
    if release_year:
        data['release_year'] = release_year

    response = requests.put(f"{API_URL}/books/{book_id}", json=data)
    result = response.json()
    print(result['message'])

def update_friend(friend_id, name=None, email=None):
    data = {}
    if name:
        data['name'] = name
    if email:
        data['email'] = email

    response = requests.put(f"{API_URL}/friends/{friend_id}", json=data)
    result = response.json()
    print(result['message'])

def delete_book(book_id):
    response = requests.delete(f"{API_URL}/books/{book_id}")
    result = response.json()
    print(result['message'])

def delete_friend(friend_id):
    response = requests.delete(f"{API_URL}/friends/{friend_id}")
    result = response.json()
    print(result['message'])

def main():
    parser = argparse.ArgumentParser(description="Library Management System Client")
    parser.add_argument("action", choices=["print_books", "print_friends", "add_book", "add_friend", "update_book", "update_friend", "delete_book", "delete_friend"])
    parser.add_argument("--author")
    parser.add_argument("--title")
    parser.add_argument("--release_year", type=int)
    parser.add_argument("--name")
    parser.add_argument("--email")
    parser.add_argument("--book_id", type=int)
    parser.add_argument("--friend_id", type=int)
    args = parser.parse_args()

    if args.action == "print_books":
        response = requests.get(f"{API_URL}/books")
        books = response.json()
        print_books(books)
    elif args.action == "print_friends":
        response = requests.get(f"{API_URL}/friends")
        friends = response.json()
        print_friends(friends)
    elif args.action == "add_book":
        add_book(args.author, args.title, args.release_year)
    elif args.action == "add_friend":
        add_friend(args.name, args.email)
    elif args.action == "update_book":
        update_book(args.book_id, args.author, args.title, args.release_year)
    elif args.action == "update_friend":
        update_friend(args.friend_id, args.name, args.email)
    elif args.action == "delete_book":
        delete_book(args.book_id)
    elif args.action == "delete_friend":
        delete_friend(args.friend_id)

if __name__ == "__main__":
    main()
