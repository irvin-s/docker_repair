FROM bobrik/curator

RUN apk --update add bash && \
    rm -rf /var/cache/apk/*

COPY curator-config.yml /config.yml
COPY curator-actions.yml /actions.yml
COPY curator-crontab /var/spool/cron/crontabs/root

ENTRYPOINT ["/usr/sbin/crond"]
CMD ["-f", "-l", "0"]
