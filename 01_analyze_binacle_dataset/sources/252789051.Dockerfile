FROM clkao/postgres-plv8:9.4-1.5  
ENV POSTGRES_USER fhirbase  
ENV POSTGRES_DB fhirbase  
COPY add_plv8_setting.sh /docker-entrypoint-initdb.d/  
COPY fhirbase-1.4.0.0.sql /docker-entrypoint-initdb.d/  

