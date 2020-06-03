FROM alpine:latest

RUN apk --no-cache add tinyproxy bash

COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
COPY wrapper.sh /wrapper.sh

CMD /wrapper.sh
