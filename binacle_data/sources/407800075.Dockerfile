FROM rabbitmq

RUN rabbitmq-plugins enable --offline rabbitmq_management
EXPOSE 15671 15672

RUN rabbitmq-plugins enable --offline rabbitmq_mqtt
EXPOSE 1883 8883

RUN echo =====RABBITMQ_VERSION: ${RABBITMQ_VERSION}
ADD https://dl.bintray.com/rabbitmq/community-plugins/rabbitmq_web_mqtt-3.6.x-14dae543.ez \
    /usr/lib/rabbitmq/lib/rabbitmq_server-$RABBITMQ_VERSION/plugins/
RUN chmod go+r /usr/lib/rabbitmq/lib/rabbitmq_server-$RABBITMQ_VERSION/plugins/rabbitmq_web_mqtt-3.6.x-14dae543.ez
EXPOSE 15675

RUN rabbitmq-plugins enable --offline rabbitmq_web_mqtt