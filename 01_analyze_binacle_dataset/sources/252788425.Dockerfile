FROM node  
  
MAINTAINER Rick Moran <moran@crowbits.com>  
  
RUN \  
apt-get update && \  
apt-get install -y --no-install-recommends mongodb-clients && \  
rm -rf /var/lib/apt/lists/*  
  
# Other containers use the stuff before this. Minimize downloads.  
RUN git clone https://github.com/CrowBits/bitcore-wallet-service.git /bws  
  
WORKDIR /bws  
  
# I have no idea why I have to do this twice.  
# Perhaps some node loving individual can explain it to me.  
RUN \  
npm install --silent ; npm install --silent && \  
sed -i 's/localhost:27017/bwsdb:27017/g' config.js && \  
sed -i 's#\x27localhost\x27#\x27locker\x27#g' config.js && \  
sed -i 's/localhost:3380/messagebroker:3380/g' config.js  
  
# This allows for communication between linked containers.  
EXPOSE 3232 3231 3380  
# Run the old noderoony  
ENTRYPOINT ["/usr/local/bin/node"]  
  
# Make it safe. Do not start anything unless we have a commandline argument.  
CMD ["--version"]  

