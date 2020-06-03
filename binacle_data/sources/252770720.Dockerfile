FROM fedora:24  
MAINTAINER Andrae Findlator <andrae.findlator@gmail.com>  
  
RUN dnf update -y  
  
COPY ./purchasing-api /Worker/  
  
EXPOSE 8100  
ENTRYPOINT ["/Worker/purchasing-api"]  
  

