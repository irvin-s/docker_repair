FROM gliderlabs/alpine:3.5

RUN apk add --no-cache curl postgresql postgresql-contrib

RUN curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64"
RUN chmod +x /usr/local/bin/gosu

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password
ENV POSTGRES_DATABASE app

ENV LINK_SCHEME postgres
ENV LINK_USERNAME $POSTGRES_USER
ENV LINK_PASSWORD $POSTGRES_PASSWORD
ENV LINK_PATH /$POSTGRES_DATABASE

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /
COPY docker-healthcheck.sh /

RUN apk del curl

ENTRYPOINT ["/docker-entrypoint.sh"]
HEALTHCHECK --interval=1s --retries=30 CMD ["/docker-healthcheck.sh"]

EXPOSE 5432
CMD ["postgres"]
