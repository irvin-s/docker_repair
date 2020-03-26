# build stage  
FROM golang:1.9.1-alpine3.6 AS builder  
ADD . /src  
RUN cd /src && go build main.go  
  
# final stage  
FROM alpine:3.6  
WORKDIR /app  
COPY \--from=builder /src/main /app/  
EXPOSE 8080  
ENTRYPOINT ./main

