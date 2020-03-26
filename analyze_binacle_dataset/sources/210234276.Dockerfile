FROM ubuntu:15.10

RUN apt-get update && \
    apt-get -y install build-essential git curl wget tree zip unzip bzr jq && \
    apt-get clean && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    npm install npm@latest -g
