from flask import Flask, request, jsonify
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models import Base, Book, Friend

app = Flask(__name__)

engine = create_engine('sqlite:///library.db')
Base.metadata.bind = engine
DBSession = sessionmaker(bind=engine)
session = DBSession()

@app.route('/api/books', methods=['GET', 'POST'])
def handle_books():
    if request.method == 'GET':
        books = session.query(Book).all()
        return jsonify([{'id': book.id, 'author': book.author, 'title': book.title, 'release_year': book.release_year} for book in books])
    
    elif request.method == 'POST':
        data = request.json
        new_book = Book(author=data['author'], title=data['title'], release_year=data['release_year'])
        session.add(new_book)
        session.commit()
        return jsonify({'message': 'Book added successfully', 'id': new_book.id})

@app.route('/api/friends', methods=['GET', 'POST'])
def handle_friends():
    if request.method == 'GET':
        friends = session.query(Friend).all()
        return jsonify([{'id': friend.id, 'name': friend.name, 'email': friend.email} for friend in friends])
    
    elif request.method == 'POST':
        data = request.json
        new_friend = Friend(name=data['name'], email=data['email'])
        session.add(new_friend)
        session.commit()
        return jsonify({'message': 'Friend added successfully', 'id': new_friend.id})


@app.route('/api/books/<int:book_id>', methods=['GET', 'PUT', 'DELETE'])
def handle_single_book(book_id):
    try:
        book = session.query(Book).filter_by(id=book_id).one()

        if request.method == 'GET':
            return jsonify({'id': book.id, 'author': book.author, 'title': book.title, 'release_year': book.release_year})
        
        elif request.method == 'PUT':
            data = request.json
            book.author = data.get('author', book.author)
            book.title = data.get('title', book.title)
            book.release_year = data.get('release_year', book.release_year)
            session.commit()
            return jsonify({'message': 'Book updated successfully'})
        
        elif request.method == 'DELETE':
            session.delete(book)
            session.commit()
            return jsonify({'message': 'Book deleted successfully'})
    
    except Exception as e:
        return jsonify({'error': str(e)}), 404
    
@app.route('/api/friends/<int:friend_id>', methods=['GET', 'PUT', 'DELETE'])
def handle_single_friend(friend_id):
    try:
        friend = session.query(Friend).filter_by(id=friend_id).one()

        if request.method == 'GET':
            return jsonify({'id': friend.id, 'name': friend.name, 'email': friend.email})
        
        elif request.method == 'PUT':
            data = request.json
            friend.name = data.get('name', friend.name)
            friend.email = data.get('email', friend.email)
            session.commit()
            return jsonify({'message': 'Friend updated successfully'})
        
        elif request.method == 'DELETE':
            session.delete(friend)
            session.commit()
            return jsonify({'message': 'Friend deleted successfully'})
    
    except Exception as e:
        return jsonify({'error': str(e)}), 404
    

if __name__ == '__main__':
    app.run(debug=True, port=3000)
