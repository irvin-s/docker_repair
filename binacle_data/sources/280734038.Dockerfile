FROM ubuntu:16.04

# Install Node.js and other dependencies
RUN apt-get update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup_7.x  | bash - && \
    apt-get -y install python build-essential nodejs git

WORKDIR /usr/src/app
ADD package.json /usr/src/app

RUN npm config set registry https://registry.npmjs.org/
RUN npm set progress=false

RUN npm install -g webpack

#RUN npm install

# Expose port
EXPOSE 8080
CMD npm install && npm run server:dev

