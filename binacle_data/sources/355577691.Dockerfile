# Copyright 2016 The Kubernetes Authors All rights reserved.
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

# FROM google/debian:wheezy
FROM google/debian:jessie

COPY sources.list /etc/apt/sources.list
COPY cassandra.list /etc/apt/sources.list.d/cassandra.list

# RUN gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
# RUN gpg --export --armor F758CE318D77295D | apt-key add -

# RUN gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
# RUN gpg --export --armor 2B5C1B00 | apt-key add -

# RUN gpg --keyserver pgp.mit.edu --recv-keys 0353B12C
# RUN gpg --export --armor 0353B12C | apt-key add -

# https://www.apache.org/dist/cassandra/KEYS
COPY cassandra.KEYS /cassandra.KEYS
RUN cat cassandra.KEYS | apt-key add - \
  && rm cassandra.KEYS 

RUN apt-get update \
  && apt-get -qq -y install procps cassandra openjdk-8-jre-headless \
  && rm -rf /var/lib/apt/lists/*

COPY cassandra.yaml /cassandra.yaml
COPY logback.xml /logback.xml
COPY run.sh /run.sh
COPY kubernetes-cassandra.jar /kubernetes-cassandra.jar

RUN chmod a+rx /run.sh && \
    mkdir -p /cassandra_data/data && \
    mv /logback.xml /etc/cassandra/ && \
    mv /cassandra.yaml /etc/cassandra/ && \
    chown -R cassandra: /etc/cassandra /cassandra_data \
      /run.sh /kubernetes-cassandra.jar && \
    chmod o+w -R /etc/cassandra /cassandra_data && \
    rm -rf \
        doc \
        man \
        info \
        locale \
        /var/lib/apt/lists/* \
        /var/log/* \
        /var/cache/debconf/* \
        common-licenses \
        ~/.bashrc \
        /etc/systemd \
        /lib/lsb \
        /lib/udev \
        /usr/share/doc/ \
        /usr/share/doc-base/ \
        /usr/share/man/ \
        /tmp/*

VOLUME ["/cassandra_data/data"] 

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service not included cause it is going away
EXPOSE 7000 7001 7199 9042   

USER cassandra

CMD /run.sh
