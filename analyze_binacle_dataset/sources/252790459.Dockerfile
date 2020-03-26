FROM node:6.11-alpine  
  
ENV GETH_HOSTNAME="localhost" GETH_RPCPORT=8545 GETH_PROTOCOL="http"  
ADD start.sh /start.sh  
  
RUN apk add --update git python make g++ && \  
npm install -g bower && \  
git clone https://github.com/provivus/explorer /app && \  
cd /app && \  
npm install && \  
bower --allow-root install && \  
apk del git python make g++ && \  
rm rm -rf /var/cache/apk/*  
  
EXPOSE 8000  
CMD ["/bin/sh", "/start.sh"]  

