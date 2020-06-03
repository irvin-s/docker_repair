FROM golang  
  
RUN mkdir -p /go/src/bitbucket.org/crowbits/worker-math_add/  
COPY . /go/src/bitbucket.org/crowbits/worker-math_add/  
  
WORKDIR /go/src/bitbucket.org/crowbits/worker-math_add/  
  
RUN go-wrapper install  
  
# this will ideally be built by the ONBUILD below ;)  
ENTRYPOINT ["/go/bin/worker-math_add"]  
  
CMD [ "-h" ]  
  
EXPOSE 7001  

