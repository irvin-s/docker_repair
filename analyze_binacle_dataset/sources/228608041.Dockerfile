FROM postgres:9.5.0 

ENV POSTGRES_USER=postgres POSTGRES_PASSWORD=secret POSTGRES_DB=dws

COPY Vx.x_init.sh /docker-entrypoint-initdb.d/
