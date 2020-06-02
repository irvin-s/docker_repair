FROM seegno/bitcoind:0.14.2-alpine
RUN apk --update --no-cache add bash
ADD bitcoin.conf /home/bitcoin/.bitcoin/
