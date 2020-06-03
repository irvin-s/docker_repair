FROM golang:onbuild  
RUN mkdir -p /go/src/app/data  
EXPOSE 8000  
VOLUME ["/go/src/app/data"]  

