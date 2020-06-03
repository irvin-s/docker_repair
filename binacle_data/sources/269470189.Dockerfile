FROM alpine:3.6

RUN apk add --no-cache git nodejs nodejs-npm 
RUN npm install --silent -g grunt-cli

RUN git clone https://github.com/EthereumEx/eth-netstats.git /var/lib/eth-netstats

WORKDIR /var/lib/eth-netstats
RUN npm install
RUN grunt all

EXPOSE 3000
ENTRYPOINT ["npm","start"]

