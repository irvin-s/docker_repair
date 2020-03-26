FROM busybox

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY binary/filebeat /filebeat
COPY filebeat.yml /filebeat.yml

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/filebeat", "-e", "-d", "*", "/filebeat.yml"]