# Pull base image  
FROM rap:latest

MAINTAINER MasonLiu "masonliuchn@gmail.com"  

EXPOSE 8080

# Define default command.  
ENTRYPOINT /etc/init.d/redis-server start && service mysql start && /usr/local/tomcat/bin/startup.sh && /bin/bash
