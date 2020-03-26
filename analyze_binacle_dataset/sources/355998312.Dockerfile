FROM node:6.10

MAINTAINER Daniel Moll

WORKDIR /home/targets-io

#USER root

#RUN apt-get update && apt-get install -y --no-install-recommends python2.7

# install dockerize 
RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.1.0/dockerize-linux-amd64-v0.1.0.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.1.0.tar.gz

# Install targets-io Prerequisites
RUN npm install -g grunt-cli
RUN npm install -g bower
RUN npm install -g forever
RUN apt-get install g++

ENV PYTHON /usr/bin/python2.7

# Install targets-io packages
ADD package.json /home/targets-io/package.json
RUN npm install --production


# Manually trigger bower. Why doesnt this work via npm install?
ADD .bowerrc /home/targets-io/.bowerrc
ADD bower.json /home/targets-io/bower.json
RUN bower install --config.interactive=false --allow-root


# Make everything available for start
ADD . /home/targets-io

ENV NODE_ENV demo


# Port 3000 for server
EXPOSE 3000

COPY docker-entrypoint.sh /entrypoint.sh

#RUN chown -R node:node /entrypoint.sh

RUN chmod +x  /entrypoint.sh

#USER node

ENTRYPOINT ["/entrypoint.sh"]

