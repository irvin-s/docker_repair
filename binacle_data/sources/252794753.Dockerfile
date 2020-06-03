FROM node:8  
# Env variables  
ENV PORT 80  
# Data Directory  
ENV DATADIR /data  
VOLUME /data  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install --loglevel warn  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 80  
EXPOSE 3282  
EXPOSE 3282/udp  
CMD npm start  

