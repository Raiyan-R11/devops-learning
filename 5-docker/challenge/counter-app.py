from flask import Flask
import redis
import socket

app = Flask(__name__)

redis_client = redis.StrictRedis(host='mydb_redis', port=6379, db=0)

container_id = socket.gethostname()

@app.route('/')
def welcome():
    return f'Welcome to the Counter App! (Container: {container_id})'

@app.route('/counter')
def counter():
    # Increment the counter in Redis
    count = redis_client.incr('counter')
    return f'Visit Counter: {count} , (Container: {container_id})'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
