FROM alpine:latest  
  
MAINTAINER Andrae Findlator <andrae.findlator@gmail.com>  
  
COPY ./profiles-api /Worker/  
  
EXPOSE 8201  
WORKDIR "/Worker"  
  
ENTRYPOINT ["/Worker/profiles-api"]  
  

