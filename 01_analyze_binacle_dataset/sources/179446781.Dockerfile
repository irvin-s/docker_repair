FROM ubuntu:14.04
MAINTAINER Kevin Smyth <kevin.m.smyth@gmail.com>

RUN apt-get -qq update && apt-get install -y --no-install-recommends apt-transport-https ca-certificates
RUN printf 'deb https://deb.nodesource.com/node_0.12/ trusty main\n' > /etc/apt/sources.list.d/nodesource-trusty.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68576280

# libkrb5-dev needed by mongoose/mongodb/mongodb-core/kerberos/build/Release/obj.target/kerberos/lib/kerberos.o
RUN apt-get -qq update && sudo apt-get install -y --no-install-recommends curl wget unzip build-essential git-core nodejs mongodb-server python moreutils ca-certificates libkrb5-dev

RUN npm install -g npm@2.12.1

RUN npm install -g gulp

RUN echo smallfiles = true >> /etc/mongodb.conf

RUN mkdir -p /mms-webcyphy
ADD package.json /mms-webcyphy/package.json
ADD bower.json /mms-webcyphy/bower.json
RUN cd /mms-webcyphy && npm install
# && bower --allow-root install </dev/null

ADD . /mms-webcyphy

VOLUME ["/mms-webcyphy"]
WORKDIR /mms-webcyphy

RUN echo '#!/bin/bash -ex' >> /root/run.sh &&\
  echo '/etc/init.d/mongodb start' >> /root/run.sh &&\
  echo 'cat src/app/mmsApp/config.client.default.json | sed s@http://localhost:3000@http://$COMPONENT_SERVER_PORT_3000_TCP_ADDR:$COMPONENT_SERVER_PORT_3000_TCP_PORT@ | sponge src/app/mmsApp/config.client.json' >> /root/run.sh &&\
  echo 'node node_modules/gulp/bin/gulp.js compile-all' >> /root/run.sh &&\
  echo 'node app.js' >> /root/run.sh


EXPOSE 8855

CMD ["bash", "-xe", "/root/run.sh"]

# docker build -t mms-webcyphy mms-webcyphy
# docker kill mms-webcyphy ; docker rm mms-webcyphy
# docker run -d --name mms-webcyphy -p 8855:8855 --link component-server:component-server -t mms-webcyphy
# sleep 5 ; docker exec mms-webcyphy mongorestore --drop

