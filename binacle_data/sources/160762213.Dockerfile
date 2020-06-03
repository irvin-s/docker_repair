FROM tomcat:8.5.34-jre8

LABEL maintainer="Ryan Frazier <ryan.frazier@sdl.usu.edu>"

RUN apt-get update && apt-get install -y unzip tar wget procps

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

# set the path of the database file when the container is run
# --env CATALINA_OPTS="-Xmx2048m -Dapplication.datadir=/var/selenium"

WORKDIR /var/
COPY openstorefront.zip ./
RUN unzip openstorefront.zip && rm openstorefront.zip

# ENV CATALINA_HOME /usr/local/tomcat
# see https://hub.docker.com/_/tomcat/

# mount the storefront.war to $CATALINA_HOME/webapps/openstorefront.war
# -v $(pwd)/openstorefront.war:/usr/local/tomcat/webapps/openstorefront.war

####################
## Start Services ##
####################

ARG STOREFRONT_HOME=/usr/local/share/openstorefront
RUN mkdir -p "$STOREFRONT_HOME" && \
	chmod 755 -R "$STOREFRONT_HOME"
WORKDIR $STOREFRONT_HOME

COPY tomcat-users.xml $CATALINA_HOME/conf/
COPY startup.sh ./

RUN chmod +x startup.sh

ENTRYPOINT ./startup.sh
