FROM ubuntu:14.04  
MAINTAINER Ayush Shanker  
  
ADD ./setup.sh /tmp/setup.sh  
ADD ./nginx /etc/init.d/nginx  
  
RUN /bin/sh /tmp/setup.sh  
  
CMD ["nginx"]  
  
EXPOSE 80  
EXPOSE 443  

