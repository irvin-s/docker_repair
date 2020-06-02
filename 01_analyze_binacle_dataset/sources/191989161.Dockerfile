From haproxy:1.5

VOLUME /app
ADD ./haproxy.cfg /app/haproxy.cfg

WORKDIR /app

CMD ["haproxy","-f","haproxy.cfg"]

