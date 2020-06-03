FROM alpine:3.5

RUN apk --update add bash curl git nodejs bitcoin==0.13.1-r0 bitcoin-cli==0.13.1-r0 bitcoin-tx==0.13.1-r0
WORKDIR /opt/ccoin
RUN git clone --depth=1 https://github.com/Colored-Coins/coloredcoinsd.git ; cd coloredcoinsd ; npm install
ADD start.sh /
RUN chmod a+x /start.sh
ADD bitcoin.conf /root/.bitcoin/
