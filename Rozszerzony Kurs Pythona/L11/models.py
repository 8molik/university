from sqlalchemy import create_engine, ForeignKey, Column, String, Integer
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.orm.exc import NoResultFound
import argparse

Base = declarative_base()

class Book(Base):
    __tablename__ = "books"

    id = Column(Integer, primary_key=True)
    author = Column(String, nullable=False)
    title = Column(String, nullable=False)
    release_year = Column(Integer, nullable=False)
    friend_id = Column(Integer, ForeignKey('friends.id'))
    friend = relationship('Friend', back_populates='borrowed_book')

    def __init__(self, author, title, release_year):
        self.author = author
        self.title = title
        self.release_year = release_year

    def __str__(self):
        return f"{self.author}, {self.title}, {self.release_year}"

class Friend(Base):
    __tablename__ = "friends"
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    email = Column(String, nullable=False)
    borrowed_book = relationship('Book', back_populates='friend')

    def __init__(self, name, email):
        self.name = name
        self.email = email

    def __str__(self):
        return f"{self.name}, {self.email}"

class Library:
    def __init__(self, url):
        self.engine = create_engine(url)
        Base.metadata.create_all(bind=self.engine)
        Session = sessionmaker(bind=self.engine)
        self.session = Session()

    def add_book(self, author, title, release_year):
        new_book = Book(author, title, release_year)
        self.session.add(new_book)
        self.session.commit()
        print(f"Added new book: {new_book}")

    def add_friend(self, name, email):
        new_friend = Friend(name, email)
        self.session.add(new_friend)
        self.session.commit()
        print(f"Added new friend: {new_friend}")

    def delete_book(self, book_id):
        try:
            book = self.session.query(Book).filter_by(id=book_id).one()
            borrowed_by = book.friend.name if book.friend else None
            if borrowed_by:
                book.friend.borrowed_book.remove(book)
                book.friend = None

            self.session.delete(book)
            self.session.commit()
            
            if borrowed_by:
                print(f"Book '{book.title}' deleted successfully. It was borrowed by {borrowed_by}.")
            else:
                print(f"Book '{book.title}' deleted successfully.")
        except NoResultFound:
            print("Book not found.")

    def delete_friend(self, friend_id):
        try:
            friend = self.session.query(Friend).filter_by(id=friend_id).one()
            for book in friend.borrowed_book:
                book.friend = None

            self.session.delete(friend)
            self.session.commit()
            print(f"Friend '{friend.name}' deleted successfully.")
        except NoResultFound:
            print("Friend not found.")

    def update_book(self, book_id, author=None, title=None, release_year=None):
        try:
            book = self.session.query(Book).filter_by(id=book_id).one()

            if author is not None:
                book.author = author
            if title is not None:
                book.title = title
            if release_year is not None:
                book.release_year = release_year

            self.session.commit()
            print(f"Book '{book.title}' updated successfully.")
        except NoResultFound:
            print("Book not found.")

    def update_friend(self, friend_id, name=None, email=None):
        try:
            friend = self.session.query(Friend).filter_by(id=friend_id).one()

            if name is not None:
                friend.name = name
            if email is not None:
                friend.email = email

            self.session.commit()
            print(f"Friend '{friend.name}' updated successfully.")
        except NoResultFound:
            print("Friend not found.")

    def borrow_book(self, book_id, friend_id):
        try:
            book = self.session.query(Book).filter_by(id=book_id).one()
            friend = self.session.query(Friend).filter_by(id=friend_id).one()
            if book.friend:
                print("Book is already borrowed.")
            else:
                book.friend = friend
                self.session.commit()
                print(f"Book '{book.title}' borrowed successfully by {friend.name}.")
        except NoResultFound:
            print("Book or friend not found.")

    def return_book(self, book_id):
        try:
            book = self.session.query(Book).filter_by(id=book_id).one()
            if book.friend:
                borrowed_by = book.friend.name
                book.friend = None
                self.session.commit()
                print(f"Book '{book.title}' returned successfully by {borrowed_by}.")
            else:
                print("Book was not borrowed.")
        except NoResultFound:
            print("Book not found.")

    def print_books(self):
        books = self.session.query(Book).all()
        for book in books:
            borrower = book.friend.name if book.friend else "Not borrowed"
            print(f"{book}, Borrowed by: {borrower}")

    def print_friends(self):
        friends = self.session.query(Friend).all()
        for friend in friends:
            borrowed_books = [book.title for book in friend.borrowed_book]
            if borrowed_books:
                books = ", ".join(borrowed_books)
            else:
                books = "-"
            print(f"{friend}, Borrowed books: {books}")

def parse_args():
    parser = argparse.ArgumentParser(description="Library Management System")
    parser.add_argument("action", choices=["add_book", "add_friend", "borrow_book", "return_book", "print_books", "print_friends", "delete_book", "delete_friend", "update_friend", "update_book"])
    parser.add_argument("--author")
    parser.add_argument("--title")
    parser.add_argument("--release_year", type=int)
    parser.add_argument("--name")
    parser.add_argument("--email")
    parser.add_argument("--book_id", type=int)
    parser.add_argument("--friend_id", type=int)
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    program = Library("sqlite:///library.db")

    if args.action == "add_book":
        program.add_book(args.author, args.title, args.release_year)
    elif args.action == "add_friend":
        program.add_friend(args.name, args.email)
    elif args.action == "borrow_book":
        program.borrow_book(args.book_id, args.friend_id)
    elif args.action == "return_book":
        program.return_book(args.book_id)
    elif args.action == "print_books":
        program.print_books()
    elif args.action == "print_friends":
        program.print_friends()
    elif args.action == "delete_book":
        program.delete_book(args.book_id)
    elif args.action == "delete_friend":
        program.delete_book(args.friend_id)
    elif args.action == "update_book":
        program.update_book(args.book_id, args.author, args.title, args.release_year)
    elif args.action == "update_friend":
        program.update_friend(args.friend_id, args.name, args.email)
    
    