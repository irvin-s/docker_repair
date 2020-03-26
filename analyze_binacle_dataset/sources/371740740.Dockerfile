FROM ubuntu:trusty

#install nodejs v4.x
RUN apt-get upgrade -yq
RUN sudo rm /var/lib/apt/lists/* -rvf
RUN sudo apt-get update -y
RUN apt-get install -yq \
    curl \
    git \
    build-essential \
    python-software-properties \
    python \
    g++ \
    make \
    nano

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

RUN npm install npm -g
RUN node -v && npm -v

#prepare tools
RUN npm install -g \
    bunyan \
    nodemon \
    gulp \
    pm2 \
    webpack
