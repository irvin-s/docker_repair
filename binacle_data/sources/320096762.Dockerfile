FROM dockette/debian:sid

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apt-get update && \
    apt-get install -y haproxy supervisor rsyslog ca-certificates && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# Supervisor configuration
ADD ./supervisor/haproxy.conf /etc/supervisor/conf.d/haproxy.conf
ADD ./supervisor/rsyslog.conf /etc/supervisor/conf.d/rsyslog.conf

# Haproxy configuration
ADD ./haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg

CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
