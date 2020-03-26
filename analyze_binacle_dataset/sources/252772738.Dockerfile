FROM golang:1.9.0 AS builder  
WORKDIR /go/src/github.com/ben-st/go-mux  
COPY . .  
RUN go get -d  
RUN CGO_ENABLED=0 GOOS=linux go build -o mux  
  
# Final image.  
FROM scratch  
LABEL maintainer="Benjamin Stein <info@diffus.org>"  
COPY \--from=builder /go/src/github.com/ben-st/go-mux/mux .  
EXPOSE 8080  
ENTRYPOINT ["/mux"]

