#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# This Dockerfile is for MyBinder support

FROM andrewosh/binder-base

USER root


# java 8
RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y -t jessie-backports install openjdk-8-jdk
RUN update-java-alternatives -s java-1.8.0-openjdk-amd64

# Spark
ENV APACHE_SPARK_VERSION 1.6.1
RUN cd /tmp && \
        wget -q http://apache.claz.org/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz -C /usr/local && \
        rm spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop2.6 spark


ENV SPARK_HOME /usr/local/spark

USER main



# install Toree
ENV TOREE_VERSION 0.1.0.dev8
RUN pip install toree===${TOREE_VERSION}
RUN jupyter toree install --user


USER root

#Eclairjs
ENV ECLAIRJS_VERSION 0.5
RUN wget -q http://repo2.maven.org/maven2/org/eclairjs/eclairjs-nashorn/${ECLAIRJS_VERSION}/eclairjs-nashorn-${ECLAIRJS_VERSION}-jar-with-dependencies.jar && \
    mkdir -p /opt/nashorn/lib && \
    mv eclairjs-nashorn-${ECLAIRJS_VERSION}-jar-with-dependencies.jar /opt/nashorn/lib/eclairjs.jar


#kernel.json
COPY kernel.json /home/main/.local/share/jupyter/kernels/eclair/


USER main


# include nice intro notebook
COPY index.ipynb $HOME/notebooks/