FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN pip install flask redis

EXPOSE 5001

CMD ["python", "counter-app.py"]