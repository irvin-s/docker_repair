# Copyright 2015 The Kubernetes Authors All rights reserved.
# Modifications copyright 2017 inovex GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM java:openjdk-8-jdk

ENV hadoop_ver 2.7.2
ENV spark_ver 2.0.1
ENV TERM xterm

# Get Hadoop from US Apache mirror and extract just the native
# libs. (Until we care about running HDFS with these containers, this
# is all we need.)
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
        tar -zx hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native

# Get Spark from US Apache mirror.
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/spark/spark-${spark_ver}/spark-${spark_ver}-bin-hadoop2.6.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-bin-hadoop2.6 spark && \
    echo Spark ${spark_ver} installed in /opt

# Add the GCS connector.
RUN mkdir /opt/spark/lib && \
    cd /opt/spark/lib && \
    curl -O https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-latest-hadoop2.jar

# If numpy is installed on a driver it needs to be installed on all
# workers, so install it everywhere
RUN apt-get update && \
    apt-get install -y python-numpy

# Install some useful tools (build fails if steps are combined)
RUN apt-get install -y nmap
RUN apt-get install -y nano
RUN apt-get install -y libcommons-jxpath-java
RUN apt-get install -y maven
RUN apt-get install -y python3

ENV PYSPARK_PYTHON=python3
RUN alias pythion=/usr/bin/python3
RUN apt-get clean

# Install gcloud
# RUN wget https://dl.google.com/dl/cloudsdk/release/install_google_cloud_sdk.bash
# RUN bash install_google_cloud_sdk.bash --disable-prompts

ADD log4j.properties /opt/spark/conf/log4j.properties
ADD start-common.sh start-worker start-master /
ADD core-site.xml /opt/spark/conf/core-site.xml
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
RUN chmod +x /start-*

ENV PATH $PATH:/opt/spark/bin
