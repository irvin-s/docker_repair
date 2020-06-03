FROM rabbitmq:3.7-management-alpine
RUN rabbitmq-plugins enable --offline rabbitmq_shovel rabbitmq_shovel_management