FROM golang:1.9.2-alpine  
MAINTAINER ductamnguyen@anduintransact.com  
  
WORKDIR /go/src/github.com/anduintransaction/fakes3  
COPY . .  
  
RUN go-wrapper install  
  
VOLUME /data/fakes3  
EXPOSE 8000  
CMD ["fakes3", "server"]  

