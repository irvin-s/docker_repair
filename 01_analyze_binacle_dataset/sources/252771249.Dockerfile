# Build stage  
FROM golang:alpine AS build-env  
COPY . $GOPATH/src/github.com/aiotrc/GoRunner  
RUN apk update && apk add git  
WORKDIR $GOPATH/src/github.com/aiotrc/GoRunner  
RUN go get -v && go build -v -o /GoRunner  
  
# Final stage  
FROM python:3-alpine  
EXPOSE 8080/tcp  
WORKDIR /app  
COPY \--from=build-env /GoRunner /app/  
COPY runtime.py /app/runtime.py  
RUN cd /app/runtime.py && python3 setup.py install  
ENTRYPOINT ["./GoRunner"]  

