FROM golang:1.7  
ADD . /go/src/github.com/cagiti/go-tawerin  
  
RUN cd /go/src/github.com/cagiti/go-tawerin;make  
  
ENTRYPOINT cd /go/src/github.com/cagiti/go-tawerin/;./go-tawerin  
  
EXPOSE 8080  

