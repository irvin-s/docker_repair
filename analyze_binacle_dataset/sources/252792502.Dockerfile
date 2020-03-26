FROM node:6-slim  
  
MAINTAINER Miguel Asencio <maasencioh@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y gnuplot && \  
rm -rf /var/lib/apt/lists/*  
  
# Create app directory  
WORKDIR /git/chemcalc-bot  
  
# Install app dependencies  
COPY package.json /git/chemcalc-bot/  
RUN npm install --production  
  
# Bundle app source  
COPY ["*.js", "*.json", "/git/chemcalc-bot/"]  
  
CMD [ "npm", "start" ]  

