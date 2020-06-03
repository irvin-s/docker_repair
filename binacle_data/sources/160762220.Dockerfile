# This dockerfile is used to build the release version of Storefront
# For a development or testing container use Docker/develop/Dockerfile
FROM tomcat:8.5.34-jre8

LABEL maintainer="Ryan Frazier <ryan.frazier@sdl.usu.edu>"

RUN apt-get update && apt-get install -y \
    curl \
    procps \
    tar \
    unzip \
    wget

###################
## ElasticSearch ##
###################

ENV ES_NAME elasticsearch
ARG ES_VERSION=6.0.1
ENV ES_FILE=$ES_NAME-$ES_VERSION
ENV ES_HOME /usr/local/share/$ES_FILE
ARG ES_TGZ_URL=https://artifacts.elastic.co/downloads/$ES_NAME/$ES_FILE.tar.gz

RUN mkdir -p "$ES_HOME" 
WORKDIR $ES_HOME
RUN wget $ES_TGZ_URL
RUN tar -C $ES_HOME -zxvf $ES_FILE.tar.gz && \
    rm $ES_FILE.tar.gz* && \
    addgroup $ES_NAME && \
	useradd --home-dir $ES_HOME --shell /bin/sh -g $ES_NAME $ES_NAME && \
    chown -R $ES_NAME:$ES_NAME $ES_HOME

################
## StoreFront ##
################

WORKDIR $CATALINA_HOME/webapps

# download the latest version of Storefront from github
RUN export STOREFRONT_WAR_URL=$(curl -s https://api.github.com/repos/di2e/openstorefront/releases/latest | grep -oP '"browser_download_url": "\K(.*)(?=")') && \
    curl -fSL $STOREFRONT_WAR_URL -O 

####################
## Start Services ##
####################

ARG STOREFRONT_HOME=/usr/local/share/openstorefront
RUN mkdir -p "$STOREFRONT_HOME" && \
	chmod 755 -R "$STOREFRONT_HOME"
WORKDIR $STOREFRONT_HOME

#COPY tomcat-users.xml $CATALINA_HOME/conf/
RUN echo -e '<?xml version="1.0" encoding="utf-8"?>\n' \
    "<tomcat-users>\n" \
    "  <role rolename=\"manager-gui\"/>\n" \
    "  <role rolename=\"manager-gui\"/>\n" \
    "  <role rolename=\"manager-script\"/>\n" \
    "  <user username=\"admin\" password=\"Secret1@\" roles=\"manager,manager-gui,manager-script\" />\n" \
    "</tomcat-users>" \
    "" > $CATALINA_HOME/conf/tomcat-users.xml

#COPY startup.sh ./
RUN echo -e '#!/bin/sh\n' \
    "\n" \
    "su - $ES_NAME -c \"ES_JAVA_OPTS=\\\"-Xms512m -Xmx512m\\\" $ES_HOME/$ES_FILE/bin/$ES_NAME -d\" \n"\
    "$CATALINA_HOME/bin/catalina.sh start \n" \
    "tail -f $CATALINA_HOME/logs/catalina.out \n" \
    "" > startup.sh

RUN chmod +x startup.sh

ENTRYPOINT ./startup.sh
