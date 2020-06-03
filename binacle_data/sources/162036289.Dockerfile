FROM ubuntu:14.04
MAINTAINER Aaron Suggs

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y awscli && \
  rm -rf /var/lib/apt/lists/*

ADD sync.sh /sync.sh

CMD /sync.sh
