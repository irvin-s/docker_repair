FROM postgres:9.6.1  
COPY *.sql /docker-entrypoint-initdb.d/  
RUN chmod a+r /docker-entrypoint-initdb.d/

