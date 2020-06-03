FROM docker:dind  
  
RUN apk add \--no-cache py-pip git openssh && pip install docker-compose  

