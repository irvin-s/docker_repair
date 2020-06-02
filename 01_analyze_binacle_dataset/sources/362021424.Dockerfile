FROM postgres:9.4

RUN apt-get update
RUN apt-get install -fy postgresql-plpython-9.4 postgresql-9.4-debversion 

