FROM library/postgres  
MAINTAINER dan budris <dbudris@bu.edu>  
  
ADD init.sql /docker-entrypoint-initdb.d/  

