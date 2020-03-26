FROM haproxy:1.7-alpine

RUN apk add --no-cache curl socat

COPY haproxy.cfg url-whitelist.lst long-requests-whitelist.lst /usr/local/etc/haproxy/

HEALTHCHECK --interval=5m --timeout=2s \
  CMD curl --fail -v --no-buffer -XGET --unix-socket /safe-socket/docker.sock  http://localhost/_ping

