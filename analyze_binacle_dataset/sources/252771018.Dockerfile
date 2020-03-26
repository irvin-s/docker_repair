FROM postgres:latest  
MAINTAINER Adrian Haasler García <dev@adrianhaasler.com>  
  
# Add authentication initialization file  
COPY authentication.sh /docker-entrypoint-initdb.d/authentication.sh  
  
# Add Stash database initialization file  
COPY stash.sh /docker-entrypoint-initdb.d/stash.sh  
  
# Default configuration  
ENV STASH_DB_NAME stashdb  
ENV STASH_DB_USER stash  
ENV STASH_DB_PASS password  

