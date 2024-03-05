# Jhanavi Dave (A20515346)
import json

from flask import Flask, jsonify, request
# cross origin resource sharing library
from flask_cors import CORS
from werkzeug.security import check_password_hash, generate_password_hash

app = Flask(__name__)
CORS(app) 

@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    # get user details
    user = get_user(username)

    if user and check_password_hash(user['password'], password):
        return jsonify({'message': 'Login successful'}), 200
    else:
        return jsonify({'message': 'Invalid username or password'}), 401

# register new user
@app.route('/api/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    password = generate_password_hash(data.get('password'), method='sha256')

    # check if suer already exists
    if is_user_exists(username):
        return jsonify({'message': 'User already exists'}), 400

    # save user details if new user
    save_user(username, password)
    return jsonify({'message': 'User registered successfully'}), 201

def get_user(username):
    # Fetch user details from your database or file
    # to be written
    pass

def is_user_exists(username):
    # Check if the user already exists in your database or file
    # to be written
    pass

def save_user(username, password):
    # Save user details to your database or file
    # to be written
    pass

# run main python app
if __name__ == '__main__':
    app.run(debug=True)
