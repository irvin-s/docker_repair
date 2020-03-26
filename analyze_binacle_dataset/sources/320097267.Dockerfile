FROM alpine:3.1

MAINTAINER Daniel Romero <infoslack@gmail.com>

RUN apk add --update postgresql curl
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64"
RUN chmod +x /usr/local/bin/gosu
RUN apk del curl && rm -rf /var/cache/apk/*

RUN mkdir /docker-entrypoint-initdb.d
RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV LANG en_US.utf8
ENV PATH /usr/lib/postgresql/9.3/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
