FROM golang:1.8.0-alpine  
WORKDIR /go/src/docker-tunnel  
COPY *.go ./  
COPY vendor vendor  
RUN go install  
EXPOSE 2375  
ENTRYPOINT ["docker-tunnel"]  
  

