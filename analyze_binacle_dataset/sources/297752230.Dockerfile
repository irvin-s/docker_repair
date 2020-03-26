FROM haproxy:1.7-alpine
RUN apk add --update curl && rm -rf /var/cache/apk/*
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates
COPY confd .
RUN chmod +x confd
COPY haproxy.toml /etc/confd/conf.d/
COPY haproxy.tmpl /etc/confd/templates/
COPY boot.sh .
COPY watcher.sh .
EXPOSE 80
CMD ["./boot.sh"]
