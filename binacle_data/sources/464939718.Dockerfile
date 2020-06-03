FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install curl gnupg gnupg1 gnupg2 python3-pip
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get -y install nodejs
RUN npm install -g configurable-http-proxy

RUN rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /app
COPY . /app
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 80
EXPOSE 7999

CMD tail -f /dev/null
