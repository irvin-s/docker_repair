FROM alpine:3.8
RUN apk update \
        && apk upgrade \
        && apk add --no-cache \
        ca-certificates \
        && update-ca-certificates 2>/dev/null || true \
        && apk add --no-cache python speedtest-cli 
RUN touch /var/log/cron.log
ADD crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt
CMD /usr/sbin/crond -f -L /var/log/cron.log 
