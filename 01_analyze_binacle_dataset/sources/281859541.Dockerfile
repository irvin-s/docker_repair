FROM node:8

ADD package*.json ./
RUN npm install

ADD contracts contracts
ADD migrations migrations
ADD test test
ADD truffle.js ./

CMD ["npm", "test"]
