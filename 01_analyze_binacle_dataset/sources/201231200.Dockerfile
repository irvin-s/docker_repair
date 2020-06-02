FROM oneops/centos7

RUN yum -y install http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-8.noarch.rpm
RUN yum -y install postgresql92-server postgresql92-contrib net-tools
RUN rm -fr /var/lib/pgsql/9.2/data/*
RUN su postgres -c '/usr/pgsql-9.2/bin/initdb -U postgres -E=UTF8 -D /var/lib/pgsql/9.2/data'
ADD ./pgsql/9.2/pg_hba.conf /var/lib/pgsql/9.2/data/pg_hba.conf
RUN chown -R postgres:postgres /var/lib/pgsql/9.2/data
COPY postgres.ini /etc/supervisord.d/postgres.ini
COPY db.sh /etc/supervisord.d/db.sh
RUN chmod +x /etc/supervisord.d/db.sh

ENV OO_HOME /home/oneops
VOLUME /var/lib/pgsql/9.2/data
EXPOSE 5432
