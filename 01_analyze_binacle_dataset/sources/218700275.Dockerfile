FROM alpine:3.1

RUN apk --update add collectd collectd-python collectd-network py-pip
RUN pip install envtpl collectd requests configargparse

ADD collectd.conf.tpl /etc/collectd/collectd.conf.tpl
ADD collect-ecs.py /usr/bin/
RUN chmod +x /usr/bin/collect-ecs.py
ADD emcecs-config.yml /usr/share/collectd/emcecs-config.yml

ENV HOSTNAME=localhost
ENV METRICS_HOST=influxdb
ENV METRICS_PORT=25826
CMD for template in /etc/collectd/collectd.conf.tpl ; do envtpl $template ; done && exec collectd -f
