FROM ubuntu:15.04  
MAINTAINER david.morcillo@codegram.com  
  
RUN apt-get update && apt-get install -y curl  
  
# Install node 4  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash && \  
apt-get install -y nodejs  
  
RUN apt-get install -y build-essential python git && npm install -g bower  
  
WORKDIR /code  
  
CMD ["npm", "start"]  

