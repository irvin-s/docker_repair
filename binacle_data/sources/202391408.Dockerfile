FROM alpine:3.3

RUN apk add --no-cache docker

COPY reissue /etc/periodic/monthly/reissue
RUN chmod a+x /etc/periodic/monthly/reissue

# Run the cron daemon with the following flags:
# -f: Foreground
# -d 8: Log to stderr, use default log level
CMD ["/usr/sbin/crond", "-f", "-d", "8"]
