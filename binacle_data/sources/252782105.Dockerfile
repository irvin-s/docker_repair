FROM golang  
  
ADD . /go/src/github.com/ciaranarcher/golang-ping  
  
WORKDIR /go/src/github.com/ciaranarcher/golang-ping  
RUN go install  
  
ENTRYPOINT /go/bin/golang-ping  
  
EXPOSE 80  

