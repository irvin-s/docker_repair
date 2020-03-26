FROM mysql  
  
MAINTAINER Alexander Ilyin <alexander@ilyin.eu>  
  
RUN usermod -u 1000 mysql  
RUN chown -Rc mysql /var/run/mysqld  

