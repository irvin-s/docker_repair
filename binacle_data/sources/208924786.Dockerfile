# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License. 
# You may obtain  a copy of the License at 
#
# http://www.apache.org/licenses/LICENSE-2.0 Unless 
# 
# required by applicable law or agreed to in writing, software 
# distributed under the License is distributed on an "AS IS" 
# BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either 
# express or implied. See the License for the specific language 
# governing permissions and limitations under the License. 

# This Dockerfile will build the required environment and software 
# stack to easily get up and running with mudrod
# For more documentation please see https://github.com/mudrod/mudrod

FROM ubuntu:16.04

MAINTAINER Mudrod Team <mudrod-all@jpl.nasa.gov>

# Get the package containing apt-add-repository installed for adding repositories
RUN apt-get update && apt-get install -y software-properties-common

# Install openJDK 1.8
RUN apt-get install -y openjdk-8-jdk 

# Install various dependencies
RUN apt-get install -y \
  build-essential \
  git \
  maven \
  openssh-client \
  openssh-server \
  vim \
  wget    

RUN echo "JAVA_HOME=/usr/bin" >> /etc/environment

RUN echo 'PATH=$PATH:HOME/bin:$JAVA_HOME/bin' >> /etc/profile &&\
    echo 'export JAVA_HOME' >> /etc/profile &&\
    echo 'export PATH' >> /etc/profile

USER root

WORKDIR /tmp

########################
# Apache Spark 1.6.2   #
########################
ENV SPARK_PKG_NAME spark-1.6.2
RUN wget http://archive.apache.org/dist/spark/$SPARK_PKG_NAME/$SPARK_PKG_NAME-bin-without-hadoop.tgz  && \
    tar -xvzf $SPARK_PKG_NAME-bin-without-hadoop.tgz && \
    rm -f $SPARK_PKG_NAME-bin-without-hadoop.tgz && \
    mv $SPARK_PKG_NAME-bin-without-hadoop /usr/local/spark

WORKDIR /usr/local

# ENV needs to be used, as the above doesn't seem to be visible from cli
ENV JAVA_HOME /usr
ENV SPARK_HOME /usr/local/spark

# so you can call 'spark-class', 'spark-shell', 'spark-sql', 'spark-submit', etc.
ENV PATH $PATH:$SPARK_HOME/bin

#######################
# Elasticsearch 2.3.4 #
#######################
ENV ES_PKG_NAME elasticsearch-2.3.4
RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.4/$ES_PKG_NAME.tar.gz && \
  tar -xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv $ES_PKG_NAME /usr/local/elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /usr/local/elasticsearch/config/elasticsearch.yml

# Expose ports.
# - 9200: HTTP
# - 9300: transport
EXPOSE 9200
EXPOSE 9300

#########################
# Mudrod Master Branch  #
#########################
WORKDIR /usr/local
RUN git clone https://github.com/mudrod/mudrod.git
ENV MUDROD_HOME /usr/local/mudrod 
WORKDIR $MUDROD_HOME
# So you can call 'mudrod'
ENV PATH $PATH:$MUDROD_HOME/bin
RUN mvn clean install

# Expose ports.
# - 8080: HTTP Jetty Port
EXPOSE 8080

# Ensure that all of the services are running
CMD sh $MUDROD_HOME/docker/run_services.sh

# Set entry point to the Mudrod executable
ENTRYPOINT ["/usr/local/mudrod/bin/mudrod"]
