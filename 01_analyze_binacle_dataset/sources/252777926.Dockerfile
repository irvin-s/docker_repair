FROM golang  
  
ADD . /go/src/github.com/aphreet/lf-fetcher  
RUN go install github.com/aphreet/lf-fetcher  
  
ENTRYPOINT /go/bin/lf-fetcher  
  
CMD [""]

