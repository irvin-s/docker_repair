FROM hypriot/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    redis-server \
    supervisor \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD supervisord.conf /etc/supervisor/supervisord.conf

USER root

RUN mkdir /root/logs

RUN bash -c "cd /root && \
    virtualenv tb-env && \
    source /root/tb-env/bin/activate && \
    pip install tipboard && \
    tipboard create_project demo"

EXPOSE 7272

VOLUME /root/.tipboard

CMD ["/usr/bin/supervisord", "-j", "/root/supervisord.pid"]
