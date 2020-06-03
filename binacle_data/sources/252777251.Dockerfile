FROM golang:1.9  
WORKDIR /go/src/tim  
  
COPY . .  
  
RUN go get ./...  
RUN go build -o /app/tim  
  
WORKDIR /app  
  
CMD ["./tim"]

