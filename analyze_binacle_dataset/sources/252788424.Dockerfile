FROM node  
  
MAINTAINER Rick Moran <moran@crowbits.com>  
  
RUN \  
apt-get update && \  
apt-get install -y --no-install-recommends mongodb-clients && \  
rm -rf /var/lib/apt/lists/*  
  
RUN git clone https://github.com/CrowBits/bitcore-wallet.git /wallet && \  
cd /wallet && \  
npm install --silent && \  
npm install --silent  
  
WORKDIR /wallet/bin  
  
ENTRYPOINT ["/wallet/bin/wallet"]  

