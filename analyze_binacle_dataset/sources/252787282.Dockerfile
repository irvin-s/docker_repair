FROM golang:1.10-alpine3.7 as builder  
  
WORKDIR /go/src/app  
COPY . .  
  
RUN apk update && apk add git  
  
RUN go get -d -v ./...  
RUN go install -v ./...  
  
CMD ["app"]  
  
FROM williamyeh/ansible:alpine3  
  
COPY \--from=builder /go/bin/app /home/app  
CMD ["/home/app"]  

