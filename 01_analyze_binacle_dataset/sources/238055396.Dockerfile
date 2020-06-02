FROM node:6-alpine
WORKDIR /opt/app
RUN npm i cc-block-explorer

FROM seegno/bitcoind:0.14.2-alpine
RUN apk --update --no-cache add nodejs bash
WORKDIR /opt/app
COPY --from=0 /opt/app /opt/app
ADD bitcoin.conf /root/.bitcoin/
ADD cc.conf /opt/app/cc.conf
ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
