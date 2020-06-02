FROM mariadb  
  
MAINTAINER Madalin Ignisca <madalin.ignisca@yahoo.com>  
  
EXPOSE 3306  
LABEL che:server:3306:ref=mariadb che:server:3306:protocol=http  
  
CMD sudo mkdir -p /etc/mysql/conf.d  
  
COPY custom.cnf /etc/mysql/conf.d/custom.cnf  

