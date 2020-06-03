FROM ubuntu  
  
RUN apt-get update && \  
apt-get -y install curl && \  
curl -sL https://deb.nodesource.com/setup | sudo bash - && \  
apt-get -y install python build-essential nodejs  
  
WORKDIR /src  
ADD . /  
RUN npm install -g bower  
RUN cd /src && npm install  
  
EXPOSE 3000  
CMD ["node", "/src/server.js"]  

