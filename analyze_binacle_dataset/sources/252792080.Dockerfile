FROM ubuntu  
MAINTAINER Evans Jahja  
RUN apt-get update && \  
apt-get install -y nodejs npm  
  
WORKDIR /app  
  
ADD package.json /app  
  
RUN npm install  
  
ADD . /app  
  
CMD ["npm", "test"]

