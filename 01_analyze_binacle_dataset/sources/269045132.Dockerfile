FROM mhart/alpine-node:latest

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
RUN git clone https://github.com/holzmaster/node-pr0gramm-miner.git /root/pr0miner
WORKDIR /root/pr0miner/
RUN npm i

ENTRYPOINT ./miner.js -u $USERNAME -t $TOKEN -j $THREADS -a
