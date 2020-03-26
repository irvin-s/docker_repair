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


FROM cassandra
RUN ln -sfn /usr/bin/python2 /usr/bin/python
RUN apt-get update && apt-get -y upgrade
RUN apt -y install build-essential
RUN apt -y install libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev
RUN apt -y install libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev
RUN apt -y install wget
RUN wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tar.xz
RUN tar xf Python-3.6.6.tar.xz
WORKDIR /Python-3.6.6
RUN ./configure --enable-optimizations
RUN make -j 8
RUN make altinstall
WORKDIR /
COPY /dist/cassandra_stress_wrapper.pex /usr/bin/cassandra_stress_wrapper.pex
RUN mkdir -p /stress

RUN apt-get install -y netcat
