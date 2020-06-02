FROM docku/nginx  
MAINTAINER Jon Chen <bsd@voltaire.sh>  
  
EXPOSE 80  
ADD pkg_adder /usr/local/bin/pkg_adder  
ADD nginx_repo.conf /etc/nginx/conf.d/repo.conf  

