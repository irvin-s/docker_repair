FROM node:8

ADD . /home/app

WORKDIR /home/app

RUN npm install -g solc@^0.4.24 && \
    npm install -g truffle@^4.1.11

RUN npm install && \
    truffle compile && \
    truffle --network test migrate

RUN npm run prepare_demo_token

CMD [ "npm", "run", "start" ]