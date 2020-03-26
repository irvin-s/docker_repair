FROM lincheney/alpine-passenger
RUN apk add --update ruby-rack && rm -rf /var/cache/apk/*
COPY config.ru /usr/src/app/
