FROM debian:wheezy  
MAINTAINER Alexander Reece <alreece45@gmail.com>  
  
# Build packages first  
COPY ./installer /opt/postfix-installer  
RUN /opt/postfix-installer/install.sh  
  
# Copy the service script and set the entrypoint  
COPY ./service.sh /opt/init-postfix.sh  
ENTRYPOINT ["/opt/init-postfix.sh"]  
EXPOSE 25  

