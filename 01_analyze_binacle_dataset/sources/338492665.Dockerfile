FROM node:10.5.0

RUN git clone https://github.com/bcoin-org/bcoin.git /bcoin && cd bcoin && git checkout 58ea98dadbbbcc2066a1d4c946cea28f1d2f942b

WORKDIR /bcoin

RUN npm install

EXPOSE 18332
EXPOSE 18333
EXPOSE 8332
EXPOSE 8333
