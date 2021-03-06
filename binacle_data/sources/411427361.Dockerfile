#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

FROM openjdk:8

LABEL MAINTAINER=dev@pinot.apache.org

ARG PINOT_BRANCH=master
ARG PINOT_GIT_URL="https://github.com/apache/incubator-pinot.git"
RUN echo "Trying to build Pinot from [ ${PINOT_GIT_URL} ] on branch [ ${PINOT_BRANCH} ]"
ENV PINOT_HOME=/opt/pinot
ENV PINOT_BUILD_DIR=/opt/pinot-build

# extra dependency for running launcher
RUN apt-get update && \
    apt-get install -y --no-install-recommends vim wget curl git maven automake bison flex g++ libboost-all-dev libevent-dev libssl-dev libtool make pkg-config && \
    rm -rf /var/lib/apt/lists/* && \
    wget http://archive.apache.org/dist/thrift/0.12.0/thrift-0.12.0.tar.gz -O /tmp/thrift-0.12.0.tar.gz && \
    tar xfz /tmp/thrift-0.12.0.tar.gz --directory /tmp && \
    base_dir=`pwd` && \
    cd /tmp/thrift-0.12.0 && \
    ./configure --with-cpp=no --with-c_glib=no --with-java=yes --with-python=no --with-ruby=no --with-erlang=no --with-go=no --with-nodejs=no --with-php=no && \
    make install && \
    cd ${base_dir}

RUN git clone ${PINOT_GIT_URL} ${PINOT_BUILD_DIR} && \
    cd ${PINOT_BUILD_DIR} && \
    git checkout ${PINOT_BRANCH} && \
    mvn install package -DskipTests -Pbin-dist -Pbuild-shaded-jar && \
    mkdir -p ${PINOT_HOME}/configs && \
    mkdir -p ${PINOT_HOME}/data && \
    cp -r pinot-distribution/target/apache-pinot-*-bin/apache-pinot-*-bin/* ${PINOT_HOME}/. && \
    chmod +x ${PINOT_HOME}/bin/*.sh && \
    mvn dependency:purge-local-repository -DactTransitively=false -DreResolve=false --fail-at-end && \
    rm -rf ${PINOT_BUILD_DIR}

VOLUME ["${PINOT_HOME}/configs", "${PINOT_HOME}/data"]

# expose ports for controller/broker/server/admin
EXPOSE 9000 8099 8098 8097 8096

WORKDIR ${PINOT_HOME}

ENTRYPOINT ["./bin/pinot-admin.sh"]

CMD ["run"]
