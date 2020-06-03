FROM golang:1.7-alpine  
  
COPY . $GOPATH/src/github.com/daehyeok/goprchecker  
WORKDIR $GOPATH/src/github.com/daehyeok/goprchecker  
  
RUN apk update && apk upgrade && apk add make git  
RUN make install  
RUN make build  
  
EXPOSE 8080  
CMD ["./goprchecker", "-addr", "0.0.0.0:8080"]  

