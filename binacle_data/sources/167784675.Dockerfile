FROM fedora:20 
MAINTAINER "Christoph Görn" <goern@redhat.com>

RUN yum -y update && yum clean all
RUN yum -y install postgresql postgresql-server postgresql-contrib && yum clean all
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh ; chmod 777 /var/lib/pgsql

##create engine DB
#RUN su - postgres -c "psql -d template1 -c \"create engine password 'ovirt';\""
#RUN su - postgres -c "psql -d template1 -c \"create database engine owner engine template template0 encoding 'UTF8' lc_collate 'en_US.UTF-8' lc_ctype 'en_US.UTF-8';\""
#
##create DWH DB
#RUN su - postgres -c "psql -d template1 -c \"create user ovirt_engine_history password 'ovirt';\""
#RUN su - postgres -c "psql -d template1 -c \"create database ovirt_engine_history owner ovirt_engine_history template template0 encoding 'UTF8' lc_collate 'en_US.UTF-8' lc_ctype 'en_US.UTF-8';\""
#
##create Reports FB
#RUN su - postgres -c "psql -d template1 -c \"create user ovirt_engine_reports password 'ovirt';\""
#RUN su - postgres -c "psql -d template1 -c \"create database ovirt_engine_reports owner ovirt_engine_history template template0 encoding 'UTF8' lc_collate 'en_US.UTF-8' lc_ctype 'en_US.UTF-8';\""
#
EXPOSE 5432

#VOLUME [ "/var/lib/pgsql/data", "/var/log" ]

WORKDIR /var/lib/pgsql

ENTRYPOINT /entrypoint.sh
