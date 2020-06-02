FROM debian:jessie  
  
MAINTAINER Byron Ruth <b@devel.io>  
  
RUN apt-get update  
RUN apt-get install -y postgresql-client  
  
WORKDIR /  
  
ADD entrypoint.sh /  
RUN chmod +x entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

