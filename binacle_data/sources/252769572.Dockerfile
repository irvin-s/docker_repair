FROM postgres:9.5  
  
RUN mkdir -p /var/lib/postgresql/kong  
COPY pgdata.tar /var/lib/postgresql/kong/  
RUN cd /var/lib/postgresql/kong/ && tar -xvf pgdata.tar  
COPY kong-0-12-1.sql /var/lib/postgresql/kong/pgdata  

