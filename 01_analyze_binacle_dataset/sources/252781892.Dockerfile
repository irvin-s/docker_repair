FROM golang:1.6  
RUN go get github.com/google/safebrowsing/cmd/sbserver  
  
WORKDIR /go/bin  
  
ENTRYPOINT ["sbserver", "-srvaddr", "0.0.0.0:80"]  

