FROM mariadb  
MAINTAINER Dogstudio <developers@dogstudio.be>  
  
ENV MYSQL_ROOT_PASSWORD docker  
ENV MYSQL_DATABASE docker_dev  
  
EXPOSE 3306  

