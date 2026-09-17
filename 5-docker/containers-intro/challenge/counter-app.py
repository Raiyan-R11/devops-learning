from flask import Flask
import redis

app = Flask(__name__)

redis_client = redis.StrictRedis(host='mydb_redis', port=6379, db=0)

@app.route('/')
def welcome():
    return 'Welcome to the Counter App!'

@app.route('/counter')
def counter():
    # Increment the counter in Redis
    count = redis_client.incr('counter')
    return f'Counter: {count}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
