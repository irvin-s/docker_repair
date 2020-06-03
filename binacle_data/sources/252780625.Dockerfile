FROM golang:latest  
  
WORKDIR /go/src/app  
  
COPY . .  
  
RUN go get -d -v ./...  
RUN go install -v ./...  
  
EXPOSE 8000  
CMD ["/go/bin/app"]  
  

