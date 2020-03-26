FROM ubuntu:14.04

MAINTAINER YanMing, yanming02@baidu.com

COPY sources.list /etc/apt/sources.list

COPY . /opt/redis/

RUN apt-get update && \
    apt-get install -y --no-install-recommends libc6-dev gcc make && \
    rm -rf /var/lib/apt/lists/* && \
    cd /opt/redis && make && \
    chmod +x /opt/redis/entrypoint.sh

ENTRYPOINT [ "/opt/redis/entrypoint.sh" ]
