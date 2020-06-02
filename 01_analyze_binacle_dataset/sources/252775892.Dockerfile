FROM postgres:9.5  
COPY atlassian.sql /docker-entrypoint-initdb.d/  

