FROM mongo:3.6.6-jessie
MAINTAINER zhouyq


COPY account-service-dump.js /tmp/
COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 27017
VOLUME /data