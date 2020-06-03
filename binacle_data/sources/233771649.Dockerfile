FROM rabbitmq:3.6.0

MAINTAINER Tim Co <tim@pinn.ai>

ENV RABBITMQ_NODENAME="rabbit"
ENV RABBITMQ_DEFAULT_USER="rabbit"
ENV RABBITMQ_DEFAULT_PASS="rabbit"

COPY rabbitmq-env.conf /etc/rabbitmq

RUN mkdir -p /var/log/rabbitmq

EXPOSE 5662
