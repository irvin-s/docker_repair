FROM alpine:latest  
  
MAINTAINER Andrae Findlator <andrae.findlator@gmail.com>  
  
COPY ./sales-api /Worker/  
  
EXPOSE 8200  
WORKDIR "/Worker"  
  
ENTRYPOINT ["/Worker/sales-api"]  

