FROM golang:1.10  
RUN mkdir /app  
ADD . /app/  
WORKDIR /app  
RUN go get -d ./...  
RUN go build -o main .  
ENTRYPOINT ["/app/main"]  
  

