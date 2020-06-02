FROM rabbitmq:3.7.15-management-alpine
ADD rabbitmq.conf /etc/rabbitmq/
ADD definitions.json /etc/rabbitmq/
RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf /etc/rabbitmq/definitions.json
CMD ["rabbitmq-server"]
