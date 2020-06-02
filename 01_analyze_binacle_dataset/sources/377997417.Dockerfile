FROM base
MAINTAINER Jacques Fuentes

RUN apt-get install -y haproxy
RUN echo 'ENABLED=1' >> /etc/default/haproxy
ADD haproxy.cfg /etc/haproxy/haproxy.cfg

ADD serf /etc/serf
ADD supervisord.conf /etc/supervisord/conf.d/supervisord.conf

EXPOSE 80 22 7946

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord/conf.d/supervisord.conf"]
