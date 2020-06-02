# Copyright 2015 Akamai Technologies, Inc. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at 
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM ubuntu
MAINTAINER Kirsten Hunter (khunter@akamai.com)
RUN apt-get update
RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev software-properties-common 
RUN add-apt-repository -y ppa:longsleep/golang-backports
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q libssl-dev python-all wget vim python-pip php php-curl ruby-dev nodejs-dev npm php-pear php-dev ruby perl golang-go git
RUN pip install httpie-edgegrid 
ADD ./examples /opt/examples
ADD ./contrib/python /opt/examples/python/contrib
WORKDIR /opt/examples/php
RUN ./composer.phar install
WORKDIR /opt/examples/ruby
RUN gem install bundler
RUN bundler install
RUN gem install akamai-edgegrid
WORKDIR /opt/examples/node
RUN npm install
RUN npm install -g n; n 7.0.0
RUN mkdir /goopt
ENV GOPATH=/goopt
RUN go get github.com/akamai/cli
WORKDIR /goopt/src/github.com/akamai/cli
ENV PATH=${PATH}:/goopt/bin
RUN curl https://glide.sh/get | sh
RUN glide install
RUN go build -o akamai . && mv akamai /usr/local/bin 
RUN chmod 755 /usr/local/bin/akamai
RUN /usr/local/bin/akamai install property
RUN /usr/local/bin/akamai install purge
WORKDIR /opt/examples/python
RUN python /opt/examples/python/tools/setup.py install
RUN cpan -i Akamai::Edgegrid LWP::Protocol::https
ADD ./MOTD /opt/MOTD
RUN echo "alias gen_edgerc=/opt/examples/python/gen_edgerc.py" >> /root/.bashrc
RUN echo "alias verify_creds=/opt/examples/python/verify_creds.py" >> /root/.bashrc
RUN echo "export PATH=${PATH}:/opt/bin"
RUN echo "cat /opt/MOTD" >> /root/.bashrc
RUN mkdir /root/.httpie
ADD ./config.json /root/.httpie/config.json
RUN echo "PS1='DevZone Hands-On Labs  >> '" >> /root/.bashrc
ENTRYPOINT ["/bin/bash"]
