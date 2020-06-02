ARG BASE
FROM redis:$BASE
COPY redis/rc.local /etc/rc.local
RUN chmod 755 /etc/rc.local
COPY redis/entrypoint /entrypoint
RUN chmod a+x /entrypoint

ENTRYPOINT ["/entrypoint"]

