FROM python:3.6-alpine

RUN apk add --no-cache bash

COPY requirements.txt /
RUN pip install -r /requirements.txt

COPY app/ /app
WORKDIR /app

EXPOSE 8765

VOLUME ["/home/bitcoin/.bitcoin"]

CMD ["python", "server.py", "--log", "/home/bitcoin/.bitcoin/testnet3/debug.log"]
