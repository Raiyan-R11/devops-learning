# Light weight image of python 3.8
FROM python:3.8-slim

# Setup working directory for the following commands
WORKDIR /app

# Copy files from the host directory(app1) to the working directory in the image(app)
COPY . . 

RUN pip install flask
EXPOSE 5005

# Start container app
CMD ["python", "app.py"]