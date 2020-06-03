FROM alpine:latest  
  
MAINTAINER Andrae Findlator <andrae.findlator@gmail.com>  
  
COPY ./auth-api /Worker/  
  
EXPOSE 8300  
WORKDIR "/Worker"  
  
ENTRYPOINT ["/Worker/auth-api"]  
  

