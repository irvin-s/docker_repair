FROM mysql  
MAINTAINER Pieter Smit <drakedroidapps@gmail.com>  
  
COPY scripts /tmp  
COPY import_database.sql /tmp/import_database.sql  
  
RUN chmod +x /tmp/newEntrypoint.sh  
ENTRYPOINT ["/tmp/newEntrypoint.sh"]  

