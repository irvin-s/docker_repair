FROM python:3.6

RUN apt update && apt upgrade -y
RUN apt install -y socat
RUN pip install pycrypto

WORKDIR /root
COPY flag .
COPY server.py .

CMD socat TCP-LISTEN:8000,fork,reuseaddr EXEC:"python server.py"
