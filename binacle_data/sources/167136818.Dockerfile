FROM ubuntu:16.04
MAINTAINER Kevin Ellis

ENV LAST_MODIFIED "2016-04-28 K Ellis"

RUN apt-get update
RUN apt-get install postfix rsyslog -y
RUN apt-get upgrade bash -y

ADD conf/main.cf /
ADD conf/startservices.sh /
RUN chmod +x startservices.sh

ENTRYPOINT ["/startservices.sh"]