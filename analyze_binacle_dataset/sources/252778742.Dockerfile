FROM postgres:9.6-alpine  
  
ENV POSTGRES_USER=budgetkey  
ENV POSTGRES_DB=budgetkey  
ENV PGDATA=/var/lib/postgresql/data/db  
COPY *.sql /docker-entrypoint-initdb.d/  
  
VOLUME ["/var/lib/postgresql/data/db"]  
  

