FROM ubuntu
MAINTAINER Kirsten Hunter (khunter@akamai.com)
RUN apt-get update
RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev software-properties-common 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q libssl-dev python-all wget vim python-pip php php-curl ruby-dev nodejs-dev npm php-pear php-dev ruby perl git screen

RUN curl -sL https://deb.nodesource.com/setup_4.x |  bash -
RUN apt-get install -y --force-yes nodejs
RUN mkdir -p /data/db
ADD . /opt
WORKDIR /opt/ruby
RUN gem install bundler
RUN bundle install
WORKDIR /opt/python
RUN pip install -r requirements.txt
WORKDIR /opt/node
RUN npm install
WORKDIR /opt/perl
RUN cpan -i -f Dancer Dancer::Plugin::CRUD MongoDB JSON YAML
WORKDIR /opt/php
RUN php composer.phar install
WORKDIR /opt/data
EXPOSE 8080
ADD ./MOTD /opt/MOTD
RUN echo "cat /opt/MOTD" >> /root/.bashrc
ENTRYPOINT ["/bin/bash"]
