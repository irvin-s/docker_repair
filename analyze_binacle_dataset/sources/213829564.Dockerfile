# https://registry.hub.docker.com/_/postgres/
FROM postgres

ADD /images/postgres/entrypoint.sh /entrypoint.sh
ADD /images/postgres/create-database.sh /docker-entrypoint-initdb.d/create-database.sh

ENV PGDATA /data/postgresql/main

ENTRYPOINT ["/entrypoint.sh"]
CMD ["postgres"]