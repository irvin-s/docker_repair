FROM node:4.2.4-wheezy  
MAINTAINER Alex Flores <me@alexflor.es>  
  
ADD . /app  
WORKDIR /app  
  
RUN DEBIAN_FRONTEND=noninteractive \  
apt-get -q2 -y update && \  
apt-get -y upgrade  
  
RUN npm install  
  
  
EXPOSE 5000  
CMD ["npm", "start"]  

