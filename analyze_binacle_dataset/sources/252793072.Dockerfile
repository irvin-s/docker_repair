FROM ubuntu  
  
MAINTAINER Francisco Calaca  
  
RUN apt-get update  
RUN apt-get install -y postgresql  
RUN apt-get clean  
  
CMD service postgresql start && /bin/bash  

