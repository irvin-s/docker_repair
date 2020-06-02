FROM alpine:3.8

RUN \
    apk add --update python py-pip monit docker tzdata openssl && \
    pip install --upgrade plumbum && \
    cp /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    echo "America/Chicago" > /etc/timezone && date && \
    rm -rf /var/cache/apk/*

ADD ./scripts /srv/scripts
ADD ./monitrc /etc/monitrc
ADD conf/ /etc/monit/conf.d/
RUN mkdir -p /var/lib/monit/ && chmod +x /srv/scripts/* && chmod 600 /etc/monitrc

CMD ["/usr/bin/monit", "-Ic", "/etc/monitrc"]
EXPOSE 9009
