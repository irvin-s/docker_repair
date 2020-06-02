FROM python:3

WORKDIR /app/
COPY ./src/ .

CMD ["python", "example.py"]