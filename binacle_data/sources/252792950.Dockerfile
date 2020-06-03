FROM golang:1.10-alpine  
LABEL maintainer="Eric Chang <chiahan1123@gmail.com>"  
  
COPY main.go /main.go  
ENTRYPOINT go run /main.go  

