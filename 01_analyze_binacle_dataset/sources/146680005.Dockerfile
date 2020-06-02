FROM debian:jessie
MAINTAINER Clément Schreiner <clement@mux.me>

RUN apt-get update && apt-get install -y postgresql-9.4

USER postgres



RUN    /etc/init.d/postgresql start &&\
       createuser debile &&\
       psql --command "ALTER USER debile WITH PASSWORD 'debile';" &&\
       createdb -O debile debile

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.4/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf

EXPOSE 5432

VOLUME /var/log/postgresql

CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D", "/var/lib/postgresql/9.4/main", "-c", "config_file=/etc/postgresql/9.4/main/postgresql.conf"]
