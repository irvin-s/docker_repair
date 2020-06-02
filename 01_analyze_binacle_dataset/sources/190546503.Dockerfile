FROM haproxy:1.5

RUN groupadd haproxy && useradd -g haproxy haproxy
RUN mkdir /var/lib/haproxy

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
