FROM postgres:9.4
MAINTAINER hadrien.mary@gmail.com

# Define some variables
ENV PGDATA /var/lib/postgresql/data
ENV PGBIN /usr/lib/postgresql/9.4/bin/

ENV INITDB $PGBIN/initdb
ENV EXEC $PGBIN/postgres

ENV PORT 5432

COPY start.sh /start.sh
COPY init.sh /init.sh

CMD ["bash", "/start.sh"]
