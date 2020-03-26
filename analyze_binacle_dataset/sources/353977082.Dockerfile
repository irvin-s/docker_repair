FROM alpine:3.6
MAINTAINER source{d}

ENV CONFIG_DBHOST=postgres
ENV CONFIG_BROKER_URL=amqp://guest:guest@rabbitmq:5672/

RUN apk add --no-cache ca-certificates

ADD build/rovers_linux_amd64/rovers /bin/

CMD ["rovers","repos"]
