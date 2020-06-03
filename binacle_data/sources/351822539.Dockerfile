FROM nachtmaar/androlyze_base:latest
MAINTAINER Nils Schmidt <schmidt89@informatik.uni-marburg.de>

#####################################################
### Installation
#####################################################

RUN apt-get update
RUN apt-get install -y --no-install-recommends rabbitmq-server \
    # create ssl-cert group \
    ssl-cert \
             \
    # and add mongodb to it \
    && usermod -a -G ssl-cert rabbitmq

# enable the management plugin
RUN rabbitmq-plugins enable rabbitmq_management

# add rabbitmq service
RUN mkdir /etc/service/rabbitmq
ADD rabbitmq.sh /etc/service/rabbitmq/run

# configure rabbitmq
# trick rabbitmq into creating/reusing same mnesia structure
RUN echo "NODENAME=rabbit@localhost" > /etc/rabbitmq/rabbitmq-env.conf

RUN mkdir /etc/androlyze_init/
ADD rabbitmq_init.sh rabbitmq_ssl_init.sh /etc/androlyze_init/

# expose non-ssl and ssl port
EXPOSE 5671 5672
# rabbitmq management plugin
EXPOSE 15672

VOLUME /var/lib/rabbitmq

CMD ["/sbin/my_init"]