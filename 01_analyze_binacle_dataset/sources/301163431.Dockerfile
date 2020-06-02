FROM haproxy:1.6

COPY haproxy-entrypoint.sh /

RUN chmod +x /haproxy-entrypoint.sh

EXPOSE 6379
EXPOSE 9000

ENTRYPOINT [ "/haproxy-entrypoint.sh" ]

CMD [ "haproxy", "-f", "/etc/haproxy/haproxy.cfg" ]
