FROM ubuntu:14.04
MAINTAINER Kevin Smyth <kevin.m.smyth@gmail.com>

RUN apt-get -qq update && apt-get install -y --no-install-recommends apt-transport-https ca-certificates
RUN printf 'deb https://deb.nodesource.com/node_0.12/ trusty main\n' > /etc/apt/sources.list.d/nodesource-trusty.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68576280

RUN apt-get -qq update && sudo apt-get install -y --no-install-recommends curl curl unzip build-essential openjdk-7-jdk git-core nodejs python

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

# RUN ln -s /usr/bin/nodejs /usr/bin/node
# RUN echo -e '#!/bin/sh\nnode /usr/local/lib/node_modules/npm/bin/npm-cli.js "$@"' > /usr/bin/npm && chmod ugo+x /usr/bin/npm

RUN npm install -g npm@2.14.1


# Install Elasticsearch.
ENV ES_PKG_NAME elasticsearch-1.7.1

RUN \
  cd / && \
  curl -f -s -S https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz | tar xvz && \
  mv /$ES_PKG_NAME /elasticsearch

#   - 9200: elastic HTTP
#   - 9300: elastic transport
# EXPOSE 9200
# EXPOSE 9300
# VOLUME ["/data"]

# Mount elasticsearch.yml config
# ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
# WORKDIR /data

RUN npm install -g gulp bower

RUN mkdir -p /component-server/app
ADD ./package.json /component-server/app/package.json
ADD ./bower.json /component-server/app/bower.json
RUN cd /component-server/app && npm install && bower --allow-root install </dev/null

ADD . /component-server/app
ADD config.server.docker.json /component-server/app/config.server.json

WORKDIR /component-server/app
RUN echo '#!/bin/bash -ex' >> /root/run.sh &&\
  echo '/elasticsearch/bin/elasticsearch > elaticsearch.log &' >> /root/run.sh &&\
  echo 'gulp compile-all' >> /root/run.sh &&\
  echo 'sleep 5' >> /root/run.sh &&\
  echo 'node bin/www' >> /root/run.sh

EXPOSE 3000
VOLUME ["/component-server/components/"]

CMD ["bash", "-xe", "/root/run.sh"]

# docker build -t component-server component-server
# docker kill component-server ; docker rm -v component-server
# docker run --rm --name component-server -v `pwd`/morph-components:/component-server/components/  -p 3000:3000 -t component-server
# interactive for debugging: docker run -it --rm --name component-server -v `pwd`/tonkalib/components:/component-server/components/ -p 3000:3000 -t component-server bash
