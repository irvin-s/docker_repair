FROM ubuntu  
MAINTAINER Dewey Sasser <dewey@sasser.com>  
  
RUN apt-get update  
RUN apt-get -y install runit  
  
RUN apt-get clean  
  
COPY runit /etc/runit/  
  
CMD exec /sbin/runit  
  

