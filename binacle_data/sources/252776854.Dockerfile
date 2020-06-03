FROM debian:jessie  
  
MAINTAINER Wufu CC <ccwufu@gmail.com>  
RUN apt-get update && apt-get install -y cowsay fortune  
COPY entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

