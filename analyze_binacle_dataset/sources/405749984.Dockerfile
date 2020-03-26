# Copyright (c) 2018 Intel Corporation
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


FROM centos:7

RUN yum -y update && yum -y install java-1.8.0-openjdk-devel wget git patch which epel-release nc
RUN yum -y install python2-pip python36 && pip install cqlsh

# Download Apache Maven.
RUN wget -O /tmp/apache-maven-3.5.4-bin.tar.gz http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz

# Download YCSB orignal code.
RUN git clone --depth 1 --branch 0.14.0 https://github.com/brianfrankcooper/YCSB /opt/ycsb

# Install mvn in /opt/maven
RUN tar -C /tmp -xzf /tmp/apache-maven-3.5.4-bin.tar.gz && mv /tmp/apache-maven-3.5.4 /opt/maven

# Apply intel patch that allow to generate variable (sine-shaped) amount of QPS.
WORKDIR "/opt/ycsb"
COPY intel.patch /opt/ycsb/
RUN patch -p1 -i intel.patch

# Required for running /opt/ycsb.
RUN ln -sf /opt/maven/bin/mvn /usr/bin/mvn

# Build ycsb.
RUN /opt/maven/bin/mvn -pl com.yahoo.ycsb:core,com.yahoo.ycsb:cassandra-binding,com.yahoo.ycsb:memcached-binding -am clean package -X -Dcheckstyle.skip dependency:build-classpath -DincludeScope=compile -Dmdep.outputFilterFile=true

RUN echo 'export M2_HOME=/usr/local/maven' >> /etc/profile.d/maven.sh
RUN echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh

# Adding YCSB wrapper
COPY /dist/ycsb_wrapper.pex /usr/bin/

ENTRYPOINT ["./bin/ycsb"]
