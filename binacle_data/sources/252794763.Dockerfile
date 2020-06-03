FROM node:8  
ENV PORT 80  
ENV CONFIGDIR /data  
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
CMD DEBUG=public-archives npm start

