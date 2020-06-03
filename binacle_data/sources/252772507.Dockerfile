FROM mysql:5.6  
MAINTAINER Ilya Rumyantsev <explosivebit@gmail.com>  
  
ADD conf.d/my.cnf /etc/mysql/conf.d/my.cnf  
  
CMD ["mysqld"]  
  
EXPOSE 3306  

