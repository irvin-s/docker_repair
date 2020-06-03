FROM eeacms/docker-gc

MAINTAINER Chris Fordham <chris@fordham-nagy.id.au>

ENV CRON_SCHEDULE='0,30 * * * *'
ENV LOG_TO_SYSLOG=0
ENV SYSLOG_FACILITY=user
ENV SYSLOG_LEVEL=info
ENV SYSLOG_TAG=docker-gc
ENV DRY_RUN=false
ENV DRY_RUN_CONTAINERS=false
ENV DRY_RUN_IMAGES=false

COPY root.cron /var/spool/cron/crontabs/root
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

VOLUME /var/spool/cron

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["crond", "-l", "2", "-f"]
