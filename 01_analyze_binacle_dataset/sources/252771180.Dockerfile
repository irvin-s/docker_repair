FROM golang:1.9-alpine  
  
RUN apk add \--no-cache git  
RUN go get -u github.com/derekparker/delve/cmd/dlv  
  
EXPOSE 2345  
EXPOSE 80  
  
ENV PORT 80  

