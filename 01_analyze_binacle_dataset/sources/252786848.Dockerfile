FROM mysql  
MAINTAINER Manuel Lara Caro <manuel.lara@gmail.com>  
  
COPY config/*.sql /docker-entrypoint-initdb.d/  
  
EXPOSE 3690

