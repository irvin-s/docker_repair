FROM node:latest  
  
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz &&\  
tar xzvf ta-lib-0.4.0-src.tar.gz && \  
cd ta-lib && \  
./configure && \  
make && \  
make install && \  
cd .. && \  
rm -rf ta-lib*  
  
ADD . /app  
WORKDIR /app  
  
RUN npm install  

