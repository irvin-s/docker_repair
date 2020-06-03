FROM golang  
  
RUN mkdir -p /go/src/bitbucket.org/crowbits/go_nats_worker/  
COPY . /go/src/bitbucket.org/crowbits/go_nats_worker/  
  
WORKDIR /go/src/bitbucket.org/crowbits/go_nats_worker/  
  
RUN go-wrapper install  
  
# this will ideally be built by the ONBUILD below ;)  
ENTRYPOINT ["/go/bin/go_nats_worker"]  
  
CMD [ "-h" ]  
  
EXPOSE 7001  

