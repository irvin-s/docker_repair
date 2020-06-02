FROM mysql:5.7.16

MAINTAINER Johannes Unterstein <junterstein@mesosphere.io>

ENV MYSQL_DATABASE=chuck \
	MYSQL_USER=chuck \
	MYSQL_PASSWORD=norris \
    MYSQL_RANDOM_ROOT_PASSWORD=yes

ADD init.sql /docker-entrypoint-initdb.d
