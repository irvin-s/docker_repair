FROM mysql:5.7  
MAINTAINER Alberto Brigandì <a.brigandi@reply.it>  
  
# Copy MySQL custom configuration file (to override default configs)  
COPY /custom.cnf /etc/mysql/conf.d/  
COPY /MySQL-jbpm-schema.sql /docker-entrypoint-initdb.d/  

