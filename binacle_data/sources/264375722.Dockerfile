FROM phusion/passenger-nodejs
# FROM golden/meteor-dev
# FROM node

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y curl
RUN curl https://install.meteor.com/ | sh
WORKDIR /opt/application




RUN apt-get install -y phantomjs

ADD .meteor/packages /tmp/app/.meteor/packages
ADD .meteor/release /tmp/app/.meteor/release
WORKDIR /tmp/app/
# This is a hack to force meteor to install the dependencies.
RUN meteor bundle tmp.tgz

ADD . /tmp/app/

RUN meteor bundle --directory /opt/application/

WORKDIR /opt/application/
RUN (cd programs/server && npm install)

EXPOSE 3000

CMD ROOT_URL=http://talentsrs.com/ \
    PORT=3000 \
    MONGO_URL=mongodb://$MONGO_PORT_27017_TCP_ADDR/lesschobo \
    METEOR_SETTINGS=$(cat /tmp/app/settings.json) \
    node main.js

