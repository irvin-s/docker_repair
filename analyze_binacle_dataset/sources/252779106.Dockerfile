FROM alpine:3.3  
MAINTAINER tobe tobeg3oogle@gmail.com, Bill ozbillwang@gmail.com  
  
# Install Golang  
RUN apk --update add go git  
ENV GOPATH /go  
ENV PATH /go/bin/:$PATH  
  
# Install dependency  
RUN go get github.com/astaxie/beego  
RUN go get github.com/tobegit3hub/seagull/  
  
WORKDIR ${GOPATH}/src/github.com/tobegit3hub/seagull/  
  
# Expose the port  
EXPOSE 10086  
# Run the server  
CMD ["seagull"]  

