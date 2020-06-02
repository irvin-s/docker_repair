FROM node:10.5.0

RUN git clone https://github.com/bcoin-org/bcash.git /bcash && cd bcash && git checkout 4210033b8a8237b76d1696cf63e4cd6a402a412c

WORKDIR /bcash

RUN npm install

EXPOSE 18332
EXPOSE 18333
EXPOSE 8332
EXPOSE 8333
