FROM postgres:9.3.5
MAINTAINER "Moran Goldboim" <mgoldboi@redhat.com>

RUN su - postgres -c "psql -d template1 -c \"create engine password 'ovirt';\""
RUN su - postgres -c "psql -d template1 -c \"create database engine owner engine template template0 encoding 'UTF8' lc_collate 'en_US.UTF-8' lc_ctype 'en_US.UTF-8';\""

#create Reports FB
#RUN su - postgres -c "psql -d template1 -c \"create user ovirt_engine_reports password 'ovirt';\""
#RUN su - postgres -c "psql -d template1 -c \"create database ovirt_engine_reports owner ovirt_engine_history template template0 encoding 'UTF8' lc_collate 'en_US.UTF-8' lc_ctype 'en_US.UTF-8';\""
