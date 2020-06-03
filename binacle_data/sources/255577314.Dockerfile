FROM luiscoms/openshift-rabbitmq

RUN /usr/sbin/rabbitmq-plugins enable --offline rabbitmq_management
EXPOSE 15671 15672
