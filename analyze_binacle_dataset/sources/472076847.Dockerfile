FROM rabbitmq:3.7
RUN rabbitmq-plugins enable rabbitmq_management
EXPOSE 15672
EXPOSE 5672