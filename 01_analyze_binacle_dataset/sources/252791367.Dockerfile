FROM debian:jessie  
  
RUN apt-get update && apt-get install -y hugs98  
RUN mkdir code  
WORKDIR /code  
ENTRYPOINT ["hugs"]  

