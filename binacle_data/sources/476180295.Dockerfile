# RabbitMQ
# @version 3.4.1
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:centos7

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

RUN su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm'
RUN yum install -y install wget telnet tar erlang
RUN wget -nv -O - http://www.rabbitmq.com/releases/rabbitmq-server/v3.4.1/rabbitmq-server-generic-unix-3.4.1.tar.gz | tar zx
RUN mv rabbitmq_server-3.4.1 /usr/local/rabbitmq
RUN ln -s /usr/local/rabbitmq/sbin/* /usr/local/sbin

RUN echo "[{rabbit, [{loopback_users, []}]}]." > /usr/local/rabbitmq/etc/rabbitmq/rabbitmq.config
RUN rabbitmq-plugins enable rabbitmq_management
RUN rabbitmq-plugins enable rabbitmq_stomp

RUN mkdir /etc/rabbitmq
VOLUME ["/usr/local/rabbitmq/etc/rabbitmq"]
ENTRYPOINT [ "rabbitmq-server" ] 
EXPOSE 5671 5672 15672 61613 61614 1883 8883
