FROM upfluence/sensu-base:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

RUN gem install sensu-plugin

COPY run.sh /sensu/run.sh
COPY env_to_config.rb /sensu/env_to_config.rb

RUN mkdir -p /etc/sensu/conf.d

ENV SENSU_NAME default_client
ENV SENSU_ADDRESS 127.0.0.1
ENV SENSU_KEEP_ALIVE_WARNING 60
ENV SENSU_KEEP_ALIVE_CRITICAL 120
ENV SENSU_KEEP_ALIVE_HANDLER keepalive
ENV SENSU_SUBSCRIPTIONS none

CMD ./run.sh
