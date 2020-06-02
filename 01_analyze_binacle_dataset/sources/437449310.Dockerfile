FROM quay.io/modcloth/build-essential:latest
MAINTAINER Dan Buch <d.buch@modcloth.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq && \
    apt-get install -yq python-software-properties && \
    apt-add-repository -y ppa:chris-lea/redis-server && \
    apt-get update -yq && \
    apt-get install -yq redis-server && \
    mkdir -p /redis-data
ADD ./bin /redis-bin
ADD ./etc /redis-etc

VOLUME ["/redis-data"]
EXPOSE 6379

CMD ["/redis-bin/run-redis-server"]
