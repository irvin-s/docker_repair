FROM redis:latest

EXPOSE 26379

COPY sentinel-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/sentinel-entrypoint.sh

ENTRYPOINT ["sentinel-entrypoint.sh"]

CMD [ "redis-server", "/etc/redis/sentinel.conf", "--sentinel" ]
