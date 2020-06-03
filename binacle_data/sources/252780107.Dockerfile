FROM golang:1  
RUN go get github.com/timewasted/go-check-certs  
ENTRYPOINT ["go-check-certs"]  

