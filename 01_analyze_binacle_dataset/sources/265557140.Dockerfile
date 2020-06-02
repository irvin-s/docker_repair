# Copyright 2017, bwsoft management
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

FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=en_US.UTF-8

RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -q -y openjdk-8-jdk libsnappy-dev python3-pip

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1

RUN apt-get --assume-yes install language-pack-en

RUN python -m pip install --upgrade pip requests

RUN apt-get --assume-yes install wget pandoc && \\
python -m pip install nose pypandoc && \\
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz && \\
tar -xvf spark-2.1.0-bin-hadoop2.7.tgz && \\
cd spark-2.1.0-bin-hadoop2.7/python/ && \\
python setup.py install && \\
apt-get clean

COPY requirements.txt /requirements.txt
RUN python -m pip install -r /requirements.txt

CMD /bin/bash
