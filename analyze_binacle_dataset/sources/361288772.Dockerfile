FROM node:5.0.0
MAINTAINER Jason Wohlgemuth
RUN npm install yo grunt-cli generator-omaha -g
RUN adduser --disabled-password --gecos "" yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
USER yeoman
WORKDIR /home/yeoman
EXPOSE 1337
