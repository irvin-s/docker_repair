FROM ubuntu:latest  
  
MAINTAINER adam.copley <adam.copley@arola.co.uk>  
  
ENV ROOT_URL=http://localhost:3000  
ENV MONGO_URL=mongodb://rocketchat_db/rocketchat  
ENV PORT=3000  
# Get dependencies  
RUN apt-get update -y  
RUN apt-get install -y \  
npm \  
nodejs \  
build-essential \  
curl  
  
WORKDIR /opt  
  
# Install the tool to change the version of node  
RUN npm install -g n  
  
# Change node version to 4.5  
RUN n 8.9.3  
  
# Get rocketchat  
RUN curl -L https://releases.rocket.chat/latest/download -o rocketchat.tar  
RUN tar -xf rocketchat.tar  
RUN mv bundle rocketchat  
  
WORKDIR /opt/rocketchat/programs/server  
RUN npm install  
  
WORKDIR /opt/rocketchat  
  
CMD node main.js  

