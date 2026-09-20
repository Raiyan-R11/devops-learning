# Light weight image of python 3.8
FROM python:3.8-slim

# Setup working directory for the following commands
WORKDIR /app

# Copy files from the host directory(app1) to the working directory in the image(app)
COPY . . 

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

RUN pip install flask mysqlclient
EXPOSE 5002

# Start container app
CMD ["python", "app.py"]