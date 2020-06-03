FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y postgresql-9.5
USER postgres
RUN echo "host\tall\t\tall\t\t0.0.0.0/0\t\tmd5" >> /etc/postgresql/9.5/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker
EXPOSE 5432
CMD ["/usr/lib/postgresql/9.5/bin/postgres", "--config-file=/etc/postgresql/9.5/main/postgresql.conf"]
