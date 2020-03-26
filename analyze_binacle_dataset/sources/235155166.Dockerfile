FROM redis:3.2-alpine
MAINTAINER Shaun Smith <disgone[@]gmail.com:>

RUN apk update && apk upgrade && apk add --update \
        curl \
        bash \
        sed

ADD sentinel.conf /etc/redis/sentinel.conf

COPY run-sentinel.sh /run-sentinel.sh

RUN chmod 777 /run-sentinel.sh

ENTRYPOINT [ "/run-sentinel.sh" ]
