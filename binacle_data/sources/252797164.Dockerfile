FROM ubuntu:14.04  
ENV DEBIAN_FRONTEND noninteractive  
ENV GIT_REPO https://github.com/osterman/geoip-api.git  
  
ENV PORT "8000"  
ENV DEBUG 0  
WORKDIR /  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends git nodejs npm ca-certificates && \  
ln -s /usr/bin/nodejs /usr/bin/node && \  
apt-get clean  
  
ENV VERSION 1.0.0  
RUN git clone $GIT_REPO /geoip-api && \  
rm -rf /geoip-api/.git && \  
cd /geoip-api/ && npm install && \  
cd node_modules/geoip-lite/ && npm run-script updatedb  
  
WORKDIR /geoip-api  
  
EXPOSE 8000  
ENTRYPOINT ["/usr/bin/nodejs", "/geoip-api/server.js"]  

