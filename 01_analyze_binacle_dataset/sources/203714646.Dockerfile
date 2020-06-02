# Copyright 2016 HTC Corporation
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

FROM ubuntu:14.04
MAINTAINER Wenrui Jiang <roy_jiang@htc.com>

# Install Redis
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server git wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN git clone --recursive https://github.com/obdg/speedo.git

WORKDIR /root/speedo/caffe

RUN ./install_dependency && \
  rm -r /tmp/* && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_LIBRARY_PATH=/usr/lib LD_LIBRARY_PATH=/usr/lib JAVA_HOME=/usr/lib/jvm/java-8-oracle

RUN make all javainstall && sudo make install

RUN ./data/cifar10/get_cifar10.sh && \
  ./examples/speedo/create_cifar10.sh

WORKDIR /root/speedo

RUN ./sbt akka:assembly && \
  cp target/scala-2.11/SpeeDO-akka-1.0.jar . && \
  rm -rf ~/.sbt target

ENTRYPOINT ["docker/entrypoint.sh"]
CMD ["master", "localhost", "3", "--test", "0", "--maxIter", "1000"]
