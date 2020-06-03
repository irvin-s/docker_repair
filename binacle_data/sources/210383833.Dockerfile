FROM willfarrell/filebeat:5

# Install deps
RUN apk add --no-cache --virtual .run-deps curl jq

COPY filebeat.yml /etc/filebeat/filebeat.yml

COPY docker-entrypoint.sh  /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [ "filebeat", "-e", "-c", "/etc/filebeat/filebeat.yml"]