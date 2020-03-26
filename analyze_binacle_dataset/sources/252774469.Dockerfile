FROM mariadb:10.1  
ENV MYSQL_ROOT_PASSWORD abc  
ENV MYSQL_DATABASE ampersand_rap3  
ENV MYSQL_USER ampersand  
ENV MYSQL_PASSWORD ampersand  
  
ADD 01_grant_ampersand.sql /docker-entrypoint-initdb.d  
ADD 02_create_tables.sql /docker-entrypoint-initdb.d  
ADD 03_populate_tables.sql /docker-entrypoint-initdb.d  

