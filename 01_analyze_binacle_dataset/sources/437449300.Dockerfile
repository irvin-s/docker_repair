FROM quay.io/modcloth/postgresql-pgdg:latest
MAINTAINER Dan Buch <d.buch@modcloth.com>

RUN apt-get install -yq \
    postgresql-9.3 \
    postgresql-client-9.3 \
    postgresql-contrib-9.3
RUN /etc/init.d/postgresql stop ; \
    rm -rf /var/lib/postgresql/9.3/main \
           /etc/postgresql/9.3/main && \
    mkdir -p /pg/db /pg/custom && \
    chown -R postgres:postgres /pg ~postgres && \
    rm -f /var/run/postgresql/.s.PGSQL.5432.lock
ADD ./bin /pg/bin

EXPOSE 5432
VOLUME ["/pg/db", "/pg/custom"]
CMD ["/pg/bin/run", "--auto"]
