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


FROM ubuntu:trusty

RUN apt-get update && apt-get install -qy scons libevent-dev gengetopt libzmq-dev git g++

RUN ln -sfn /usr/bin/python2 /usr/bin/python
RUN apt -y install wget
RUN apt-get -y install zlib1g-dev build-essential

WORKDIR /opt
RUN wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
RUN tar -xvf Python-3.6.6.tgz
WORKDIR /opt/Python-3.6.6
RUN ./configure
RUN make
RUN make install

WORKDIR /
RUN git clone https://github.com/Bplotka/mutilate.git

WORKDIR mutilate

RUN git checkout masterless && scons

COPY /dist/mutilate_wrapper.pex /usr/bin/mutilate_wrapper.pex
