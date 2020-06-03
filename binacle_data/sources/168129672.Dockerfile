FROM ubuntu:14.04

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN sudo apt-get update

# Installation:
# Update apt-get sources AND install MongoDB
RUN apt-get update && apt-get install -y mongodb-org nodejs npm

ENV SERVER_PORT 8080

# Create the MongoDB data directory
RUN mkdir -p /data/db
RUN mkdir -p /data/log
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

EXPOSE 8080
#CMD [ "mongod" ]
CMD  mongod --fork --logpath /data/log/mongodb.log --dbpath /data/db && nodejs .
#CMD [ "nodejs", "." ]
