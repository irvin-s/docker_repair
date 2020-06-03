FROM docker:18-dind  
  
RUN apk add \--no-cache python3 make && \  
pip3 install docker-compose  

