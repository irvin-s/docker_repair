FROM golang:1.6  
RUN go-wrapper download github.com/Masterminds/glide \  
&& go-wrapper install github.com/Masterminds/glide  
  
RUN mkdir -p /go/src/github.com/depsio/parsers/go-glidelock  
WORKDIR /go/src/github.com/depsio/parsers/go-glidelock  
  
COPY . /go/src/github.com/depsio/parsers/go-glidelock  
RUN glide install && go-wrapper install  
  
CMD ["go-wrapper", "run"]  

