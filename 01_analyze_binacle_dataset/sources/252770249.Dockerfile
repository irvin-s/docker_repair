FROM golang:1.8-alpine  
  
COPY server.go server.go  
  
RUN go build -o /bin/status server.go  
  
ENTRYPOINT ["status"]  

