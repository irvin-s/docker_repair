FROM alpine:3.8

ENV TIME_ZONE=America/Chicago

RUN \
    apk add --update --no-cache vnstat tzdata && \
    cp /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo "${TIME_ZONE}" > /etc/timezone && date

COPY exec.sh /exec.sh
RUN chmod +x /exec.sh
ADD index.html /index.html

CMD ["/exec.sh"]
