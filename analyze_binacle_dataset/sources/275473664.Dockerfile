FROM debian:jessie

RUN apt -y update && \
    apt -y install python3 python3-pip software-properties-common curl

RUN curl -sSL https://get.haskellstack.org/ | sh

COPY api /wn

RUN cd wn  ; stack install ; cd .. ; rm -rf /wn

WORKDIR /

