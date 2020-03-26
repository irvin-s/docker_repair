FROM golang  
RUN go get github.com/bountylabs/http_proxy  
ENTRYPOINT ["/go/bin/http_proxy"]  

