FROM alpine:3.5
RUN apk --update add bash curl jq bitcoin==0.13.1-r0 bitcoin-cli==0.13.1-r0 bitcoin-tx==0.13.1-r0
ADD bitcoin.conf /root/.bitcoin/
ADD start.sh /
RUN chmod +x /start.sh
EXPOSE 18332 18333
