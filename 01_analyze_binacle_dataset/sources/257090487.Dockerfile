FROM golang:1.11-stretch AS build

# Копируем исходный код в Docker-контейнер
ADD golang/ /opt/build/golang/
ADD common/ /opt/build/common/

# Собираем генераторы
WORKDIR /opt/build/golang
RUN go mod vendor
RUN go install ./vendor/github.com/go-swagger/go-swagger/cmd/swagger
RUN go install ./vendor/github.com/jteeuwen/go-bindata/go-bindata

# Собираем и устанавливаем пакет
RUN go generate -x tools.go
RUN go install ./cmd/hello-server


FROM ubuntu:18.04 AS release

MAINTAINER Artem V. Navrotskiy

#
# Установка postgresql
#
ENV PGVER 10
RUN apt -y update && apt install -y postgresql-$PGVER

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-$PGVER`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker &&\
    /etc/init.d/postgresql stop

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$PGVER/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/$PGVER/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/$PGVER/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Back to the root user
USER root

# Объявлем порт сервера
EXPOSE 5000

# Собранный ранее сервер
COPY --from=build go/bin/hello-server /usr/bin/

#
# Запускаем PostgreSQL и сервер
#
CMD service postgresql start && hello-server --scheme=http --port=5000 --host=0.0.0.0 --database=postgres://docker:docker@localhost/docker
