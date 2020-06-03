FROM busybox
ADD ./busybox/ /
CMD mkdir /.save
RUN mkdir -p /var/spool/cron/crontabs
RUN mkdir -p /var/run/
RUN mkdir -p /var/tmp/
RUN mkdir -p /dev/netslink/