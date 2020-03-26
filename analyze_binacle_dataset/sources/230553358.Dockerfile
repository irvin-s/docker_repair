FROM ubuntu
MAINTAINER Tony Holdstock-Brown <tony@codelitt.com>

# Note: If you're running a brand new ata container, run this to initialise your DB
#       AFTER it has been set up already.
# /usr/lib/postgresql/9.3/bin/initdb -D /var/lib/pgsql/data

RUN echo "$(cat /etc/apt/sources.list) universe multiverse" > /etc/apt/sources.list

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

RUN apt-get update
RUN apt-get install -y wget
RUN wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update
RUN apt-get -y install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

# This uses a data container to manage storage
VOLUME ["/var/lib/pgsql/data"]
RUN chown postgres:postgres /var/lib/pgsql/data

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ADD databases.txt /databases.txt

EXPOSE 5432

CMD ["/entrypoint.sh"]
