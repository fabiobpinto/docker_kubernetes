from flask import Flask, request
import psycopg2, os
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
DB_HOST = os.getenv('DB_HOST', 'db')
DB_NAME = os.getenv('POSTGRES_DB', 'usersdb')
DB_USER = os.getenv('POSTGRES_USER', 'user')
DB_PASS = os.getenv('POSTGRES_PASSWORD', 'password')

@app.route('/users', methods=['POST'])
def add_user():
    conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASS)
    cur = conn.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS users (name TEXT);")
    cur.execute("INSERT INTO users (name) VALUES (%s);", (request.json['name'],))
    conn.commit()
    cur.close(); conn.close()
    return 'User added', 201

@app.route('/users', methods=['GET'])
def list_users():
    conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASS)
    cur = conn.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS users (name TEXT);")
    cur.execute("SELECT name FROM users;")
    users = [row[0] for row in cur.fetchall()]
    cur.close(); conn.close()
    return {'users': users}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0')