FROM adite/base  
MAINTAINER tescom <tescom@atdt01410.com>  
  
RUN apt-get update && \  
apt-get install -y build-essential libssl-dev && \  
apt-get clean  
  
RUN cd /tmp && \  
wget https://nodejs.org/dist/v5.4.0/node-v5.4.0.tar.gz && \  
tar xvzf node-v5.4.0.tar.gz && \  
cd node-v5.4.0 && \  
./configure && \  
make && make install  
  
ADD basicServer.js /tmp/basicServer.js  
  
EXPOSE 1337  
CMD node /tmp/basicServer.js  

