FROM mysql:5.6  
ADD blink.cnf /etc/mysql/conf.d/blink.cnf  
  
EXPOSE 3306  

