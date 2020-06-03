FROM ubuntu:14.04  
MAINTAINER Jeremy SEBAN <jeremy@seban.eu>  
  
COPY ./helloworld /bin/helloworld  
RUN chmod +x /bin/helloworld  
  
CMD "/bin/helloworld"  

