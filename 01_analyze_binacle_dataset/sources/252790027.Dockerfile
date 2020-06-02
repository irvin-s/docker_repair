FROM golang:1.6-alpine  
  
ADD main.go /go/src/app/main.go  
  
RUN go install app  
  
EXPOSE 80  
ENTRYPOINT ["app"]  

