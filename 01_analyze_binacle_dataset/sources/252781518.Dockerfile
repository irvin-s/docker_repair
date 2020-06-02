FROM golang:1.8  
MAINTAINER Bastien Quelen <bastien.quelen@feedbooks.com>  
  
EXPOSE 3000  
RUN mkdir -p /go/src/app  
WORKDIR /go/src/app  
  
COPY . /go/src/app  
  
#VOLUME ["/go/src/app/db", "/go/src/app/public/books"]  
RUN go-wrapper download  
RUN go-wrapper install  
  
CMD ["go-wrapper", "run", "-s"]  

