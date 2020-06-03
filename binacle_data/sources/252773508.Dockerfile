FROM ubuntu:trusty  
MAINTAINER "Kamil Trzcinski <ayufan@ayufan.eu>"  
RUN # This image is based on: https://github.com/Kloadut/dokku-pg-dockerfiles  
  
ENV POSTGRESQL_VERSION 9.4  
ADD install_pgsql.sh /usr/bin/  
RUN /usr/bin/install_pgsql.sh  
  
ADD start_pgsql.sh /usr/bin/  
ADD configs/pg_hba.conf /etc/postgresql/$POSTGRESQL_VERSION/main/  
ADD configs/postgresql.conf /etc/postgresql/$POSTGRESQL_VERSION/main/  
  
VOLUME /opt/postgresql  
EXPOSE 5432  
CMD ["/usr/bin/start_pgsql.sh"]  

