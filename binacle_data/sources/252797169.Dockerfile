FROM ubuntu:14.04  
MAINTAINER Erik Osterman "e@osterman.com"  
ENV DEBIAN_FRONTEND noninteractive  
  
WORKDIR /  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends git nodejs npm ca-certificates && \  
git clone https://github.com/prawnsalad/KiwiIRC.git kiwiirc && \  
ln -s /usr/bin/nodejs /usr/bin/node && \  
apt-get clean  
  
WORKDIR /kiwiirc/  
RUN npm install  
  
ADD config.js /kiwiirc/config.js  
  
RUN ./kiwi build  
  
EXPOSE 7778  
CMD /kiwiirc/kiwi -f  

