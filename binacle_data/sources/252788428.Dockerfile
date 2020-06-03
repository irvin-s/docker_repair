FROM golang  
  
RUN mkdir -p /go/src/bitbucket.org/crowbits/publisher/  
COPY . /go/src/bitbucket.org/crowbits/publisher/  
  
WORKDIR /go/src/bitbucket.org/crowbits/publisher/  
  
RUN go-wrapper install  
RUN cp /go/bin/publisher /go/bin/loadbalancer  
  
ENTRYPOINT ["/go/bin/publisher"]  
  
CMD [ "-h" ]  
  
EXPOSE 8080  

