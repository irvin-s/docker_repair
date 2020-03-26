FROM postgres:9.5  
ADD init/db/docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/  
  
RUN ls -l /docker-entrypoint-initdb.d

