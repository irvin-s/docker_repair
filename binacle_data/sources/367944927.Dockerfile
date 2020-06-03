FROM node

RUN npm install -g web3@0.20.1
ADD ./market.js /usr/local/bin/market.js

ENTRYPOINT ["market.js"]
