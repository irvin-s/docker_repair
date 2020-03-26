FROM sflive/base

RUN apt-get install -y redis-server

EXPOSE 6379

ENTRYPOINT ["redis-server"]