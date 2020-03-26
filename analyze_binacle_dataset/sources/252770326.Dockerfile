FROM ashdev/docker-nodejs:v4.2.2  
MAINTAINER AshDev <ashdevfr@gmail.com>  
  
RUN npm config set strict-ssl false  
RUN npm install -g ember-cli  
RUN npm install -g bower  
RUN npm install -g phantomjs  
  
RUN apt-get install -y python-dev automake  
  
RUN \  
cd /tmp &&\  
git clone https://github.com/facebook/watchman.git &&\  
cd watchman &&\  
git checkout v4.1.0 &&\  
./autogen.sh &&\  
./configure &&\  
make &&\  
make install  

