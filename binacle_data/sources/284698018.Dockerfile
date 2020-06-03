FROM alpine:latest
  
RUN apk update && \
    apk upgrade && \
    echo "https://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk update && \
    apk add rabbitmq-server curl && \
    chmod -R 777 /usr/lib/rabbitmq && \
    chmod -R 777 /etc && \
    mkdir /etc/rabbitmq

COPY rabbitmq.config /var/lib/rabbitmq/

RUN rabbitmq-plugins enable rabbitmq_management && \
    rabbitmq-plugins enable rabbitmq_mqtt && \
    rabbitmq-plugins enable rabbitmq_auth_backend_ldap

CMD tail -f /dev/null
