FROM node:6.5.0

RUN mkdir -p /usr/src/app
RUN mkdir /usr/src/app/output
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY . /usr/src/app

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    make \
    python-pip \
    python2.7 \
    python2.7-dev \
    ssh \
    && apt-get autoremove \
    && apt-get clean

RUN pip install -U "pip==9.0.1"
RUN pip install -U "virtualenv==12.0.7"
RUN pip install -r "requirements.txt"

RUN npm config set python python2.7

RUN npm install

CMD node start.js
