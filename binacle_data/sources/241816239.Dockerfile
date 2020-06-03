FROM python:alpine3.6

WORKDIR /usr/src/redditwatcher
COPY . .

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "./app.py"]
