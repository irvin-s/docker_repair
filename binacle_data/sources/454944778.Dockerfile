# Copyright 2017 - Dechain User Group

FROM node:8.6.0-alpine
LABEL name=devchain

RUN apk add --update bash vim less git openssl
ENTRYPOINT /root/run-ethnetintell.sh

COPY ./files/* /root/
RUN sh /root/init.sh
