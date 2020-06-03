FROM golang:onbuild  
ADD . /go/src/github.com/bandheap/bandheap-web/  
  
RUN go install github.com/bandheap/bandheap-web  
  
ENTRYPOINT /go/bin/bandheap-web  
  
EXPOSE 8080  

