FROM library/postgres  
  
MAINTAINER Alex Chubaty <alexander.chubaty@canada.ca>  
  
ADD createTables.sql /docker-entrypoint-initdb.d/  
  

