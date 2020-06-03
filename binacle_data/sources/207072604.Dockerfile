FROM unocha/alpine-base-mongo:latest

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8

COPY run_mongo fix_* /tmp/

RUN mkdir -p /etc/services.d/mongo && \
    mv /tmp/run_mongo /etc/services.d/mongo/run && \
    mkdir -p /etc/fix-attrs.d && \
    cp /tmp/fix_data_dir /etc/fix-attrs.d/01-fix-data-dir && \
    cp /tmp/fix_logs_dir /etc/fix-attrs.d/02-fix-logs-dir

EXPOSE 27017

VOLUME /srv/db /var/log/mongodb
