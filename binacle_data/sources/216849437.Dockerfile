FROM ubuntu:14.04

MAINTAINER kiwenlau <kiwenlau@gmail.com>

# 设置时区
RUN sudo echo "Asia/Tokyo" > /etc/timezone && \
    sudo dpkg-reconfigure -f noninteractive tzdata

WORKDIR /root

# install necessary software
RUN apt-get update && apt-get install -y openssl libssl-dev rsyslog socat

# install haproxy 1.6
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:vbernat/haproxy-1.6 && \
    apt-get update && \
    apt-get install -y haproxy

# install marathon-lb 1.3.0
RUN apt-get update && \
    apt-get install -y wget python3 python3-pip python3-dateutil && \
    wget https://github.com/mesosphere/marathon-lb/archive/v1.3.0.tar.gz && \
    tar -xzvf v1.3.0.tar.gz && \
    rm v1.3.0.tar.gz && \
    mv /root/marathon-lb-1.3.0 /marathon-lb && \
    pip3 install -r /marathon-lb/requirements.txt

ENV PATH=$PATH:/marathon-lb

COPY start-marathonlb.sh /usr/local/bin/start-marathonlb.sh
COPY reload-haproxy.sh /usr/local/bin/reload-haproxy.sh

RUN chmod +x /usr/local/bin/start-marathonlb.sh && \
    chmod +x /usr/local/bin/reload-haproxy.sh

CMD [ "start-marathonlb.sh" ]
EXPOSE 80 81 443 9090