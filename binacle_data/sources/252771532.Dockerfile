FROM mysql:5.7  
MAINTAINER Adam Kempler <akempler@gmail.com>  
  
# Copy configs  
ADD conf/my.cnf /etc/mysql/conf.d/  

