FROM lyapi-baseimage:latest
MAINTAINER Lien Chiang <xsoameix@gmail.com>

USER postgres
RUN service postgresql start && \
    psql postgres -c "create user ly with createdb password 'ly';" && \
    createdb -O ly ly && \
    psql ly -c "create extension plv8;"
ADD app.ls app/app.ls
ADD lib app/lib
ADD cookbooks/ly.g0v.tw/templates/default/londiste.erb /opt/ly/londiste.ini
RUN service postgresql start && \
    cd /app && \
    lsc app.ls --db tcp://ly:ly@localhost/ly --boot && \
    export PGPASSWORD=ly && \
    curl https://dl.dropboxusercontent.com/u/30657009/ly/api.ly.bz2 | bzcat | psql -U ly -h localhost -f - && \
    londiste3 /opt/ly/londiste.ini create-root apily 'dbname=ly' && \
    londiste3 /opt/ly/londiste.ini add-table calendar sittings bills

# Configure postgres (database server)
RUN echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Configure pgqd (pgq deamon / skytools3-ticker)
ADD cookbooks/ly.g0v.tw/templates/default/pgq.erb /opt/ly/pgq.ini

CMD service postgresql start && \
    pgqd /opt/ly/pgq.ini
