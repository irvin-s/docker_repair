FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

WORKDIR /app

RUN pip install flask flask-session pycrypto

COPY . /app

ENTRYPOINT [ "python" ]

CMD [ "serve.py" ]

