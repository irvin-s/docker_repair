FROM node:10

MAINTAINER Mads M. Tandrup <mads@maetzke-tandrup.dk>

RUN npm install -g private-bower@1.1.9 && npm cache clear --force

# Bower registry, git cache and svn cache ports
EXPOSE 5678 6789 7891

VOLUME /data

WORKDIR /home/private-bower

ADD ./bowerConfig.json /home/private-bower/bowerConfig.json
ADD ./log4js.conf.json /home/private-bower/log4js.conf.json

ADD ./launch.sh /home/private-bower/launch.sh
RUN chmod +x /home/private-bower/launch.sh

# Work around company firewalls blocking the git protocol
RUN git config --global url."https://github.com/".insteadOf "git://github.com/"

RUN git config --global user.email "private-bower@example.org"
RUN git config --global user.name "Private Bower"

CMD ./launch.sh
