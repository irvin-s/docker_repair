# Copyright (C) 2013-2014 Pivotal Software, Inc. 
# 
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the under the Apache License, 
# Version 2.0 (the "License”); you may not use this file except in compliance 
# with the License. You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# 
# Fork from https://github.com/jpetazzo/dind merged with dcloud
#

FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y software-properties-common python-software-properties

RUN add-apt-repository -y ppa:fkrull/deadsnakes
RUN apt-get update -y
# Already has python 2.7
# RUN apt-get install -y python2.6 python2.6-dev
# RUN cd /usr/bin && ln -s python2.6 python

RUN apt-get install -y gcc python-dev

RUN apt-get install -y wget
RUN wget --no-check-certificate https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN python get-pip.py
RUN pip install pycrypto
RUN pip install paramiko
RUN easy_install --upgrade ecdsa

ADD . /src/dcloud

RUN cd /src/dcloud && python setup.py install --record installedFiles.txt

RUN apt-get install -qqy iptables ca-certificates lxc

# Install Docker from Docker Inc. repositories.
RUN apt-get install -qqy apt-transport-https
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get update -qq
RUN apt-get install -qqy lxc-docker

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
CMD ["wrapdocker"]

