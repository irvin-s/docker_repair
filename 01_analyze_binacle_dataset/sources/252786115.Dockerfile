FROM golang as builder  
WORKDIR /go/src/github.com/dmage/httpecho  
ADD main.go .  
RUN CGO_ENABLED=0 go install . && strip /go/bin/httpecho  
  
FROM busybox  
COPY \--from=builder /go/bin/httpecho /usr/bin/httpecho  
WORKDIR /tmp  
USER 1000  
EXPOSE 8000  
CMD ["/usr/bin/httpecho"]  

