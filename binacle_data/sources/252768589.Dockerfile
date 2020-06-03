FROM alpine:latest  
MAINTAINER Anastas Dancha <anapsix@random.io>  
RUN apk upgrade --update && \  
apk add postgresql && \  
mkdir /docker-entrypoint-initdb.d && \  
mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql  
COPY ./gosu-amd64 /usr/local/bin/gosu  
COPY docker-entrypoint.sh /entrypoint.sh  
ENV LANG en_US.utf8  
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH  
ENV PGDATA /var/lib/postgresql/data  
VOLUME /var/lib/postgresql/data  
EXPOSE 5432  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["postgres"]  

