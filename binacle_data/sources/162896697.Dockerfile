FROM debian:jessie

ENV POSTGREST_VERSION 0.4.0.0

RUN apt-get update && \
    apt-get install -y tar xz-utils wget libpq-dev postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget http://github.com/begriffs/postgrest/releases/download/v${POSTGREST_VERSION}/postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz && \
    tar --xz -xvf postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz && \
    mv postgrest /usr/local/bin/postgrest && \
    rm postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz

EXPOSE 3000

ENV PGHOST=postgres \
	PGPORT=5432 \
	PGUSER=postgres \
	PGDATABASE=postgres \
	PGPASSWORD=postgres \
	PGSCHEMA=public \
	JWT_SECRET="deadbeefcafe" \
	DB_ANON_ROLE=postgres \
	DB_POOL=10 \
	DB_MAXROWS=1000

COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
