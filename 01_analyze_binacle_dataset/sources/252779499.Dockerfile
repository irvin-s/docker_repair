FROM postgres:10  
LABEL maintainer="gaetanlongree@gmail.com"  
  
COPY powerdns.sql /docker-entrypoint-initdb.d/  
  
VOLUME /etc/postgresql  
VOLUME /var/lib/postgresql/data/pgdata  
  
EXPOSE 5432  

