FROM haproxy:1.5

RUN apt-get update
RUN apt-get install -y wget
ENV DOCKERIZE_VERSION v0.2.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg.tpl
CMD ["dockerize", "-template", "/usr/local/etc/haproxy/haproxy.cfg.tpl:/usr/local/etc/haproxy/haproxy.cfg", "haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]