FROM ubuntu:14.04

MAINTAINER M6Web <burton@m6web.fr>

RUN apt-get update

RUN apt-get -y install wget

RUN wget -qO - https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add -
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list  

RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install \
    git \
    rabbitmq-server \
    vim
    
RUN rabbitmq-plugins enable rabbitmq_management

RUN echo "[{rabbit, [{loopback_users, []}]}]." >> /etc/rabbitmq/rabbitmq.config

RUN echo 'root:root' | chpasswd

ADD docker/start.sh /root/start.sh
RUN chmod +x /root/start.sh

VOLUME ["/var/log/rabbitmq"]

EXPOSE 15672
EXPOSE 5672

CMD ["/bin/bash", "/root/start.sh"]
