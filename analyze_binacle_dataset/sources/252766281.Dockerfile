FROM docker:latest  
  
MAINTAINER Antoine Benevaut <antoine@benevaut.fr>  
  
RUN apk add --no-cache py-pip openssh-client sshpass  
RUN pip install docker-compose  

