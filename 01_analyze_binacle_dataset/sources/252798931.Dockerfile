FROM golang:1.8  
ADD . /go/src/github.com/deviceio/hub  
  
RUN cd /go/src/github.com/deviceio/hub  
RUN go install github.com/deviceio/hub/cmd/deviceio-hub  
  
RUN mkdir -p /etc/deviceio/hub && echo "{}" > /etc/deviceio/hub/config.json  
  
EXPOSE 4431 5531 8975  
USER nobody  
  
ENTRYPOINT ["deviceio-hub"]

