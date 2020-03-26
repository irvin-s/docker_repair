#----------------------------
# EVA-EOS-DEV-Base
# EvaCoop base image of EOSREF-DEV
#----------------------------
# VERSION 1.1.0
# AUTHOR: Merouane Benthameur
# DESCRIPTION: base image of EOSREF-DEV

FROM eosio/eos-dev:v1.0.4
MAINTAINER Raphael gaudreault <raphael.gaudreault@eva.coop>
LABEL authors="raphael.gaudreault@eva.coop"

COPY ./eosref-entrypoint-multindex.sh /
COPY ./multindex /opt/eosio/bin/data-dir/multindex

RUN chmod +x /eosref-entrypoint-multindex.sh

# Install nodejs dependencies/
RUN apt-get update \
    && apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get -y install nodejs
COPY ./js /opt/eosio/bin/data-dir/js
RUN  cd /opt/eosio/bin/data-dir/js && npm install
