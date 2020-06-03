FROM debian:jessie  
  
MAINTAINER Cedric Gatay <c.gatay@code-troopers.com>  
  
# FreeTDS to allow sourcing of sql dump  
RUN apt-get update && apt-get install -yq freetds-bin bash  
  
VOLUME /app  

