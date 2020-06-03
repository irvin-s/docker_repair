FROM arm32v6/haproxy:1.9.7-alpine

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
