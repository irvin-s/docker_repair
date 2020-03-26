FROM busybox:latest

VOLUME /var/lib/mysql
VOLUME /usr/share/elasticsearch/data
VOLUME /data

CMD /bin/sh