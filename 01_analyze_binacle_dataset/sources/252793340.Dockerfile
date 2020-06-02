FROM dans00/docker-confd:latest  
MAINTAINER Dan Sloan <dan@dansloan.org>  
  
# Update package index when we install mariadb  
# We need pwgen for generating random internal password  
RUN apk add --update mariadb mariadb-client pwgen  
  
COPY docker-init /docker-init  
  
VOLUME /var/lib/mysql  
  
# Ports exposed for this container  
EXPOSE 3306  

